library(rstan)
library(tidyverse)
rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())
RE_RUN = F

log_logistic = function(beta,  x){
  y = exp(beta[1]) + exp(beta[2]) /  (1 + (x / exp(beta[3])) ^ (- exp(beta[4])));
  return(y);
}

load('Data/Serology/serology_all.RDS')
std_data$Abs = std_data$Abs.x
xx=std_data %>% group_by(plate_ID, true_conc) %>%
  mutate(diff = abs(diff(Abs))) 
plot(jitter(xx$true_conc), xx$diff)

output_df_unk_DBS = output_df_unk %>% filter(sample_type == 'DBS')
output_df_unk_serum = output_df_unk %>% filter(sample_type == 'serum')

res_unique = output_df_unk %>% arrange(ID) %>%
  distinct(ID, .keep_all = T)

## Make stan datasets
stan_data_controls = list(N_controls=nrow(std_data),
                          K_plates=max(std_data$plate_ID_int),
                          conc_controls = std_data$true_conc/200,
                          absorb_controls=std_data$Abs,
                          ind_plate_controls=std_data$plate_ID_int)

stan_data_serum = list(K_plates=max(std_data$plate_ID_int),
                       N_sample = max(output_df_unk_serum$ID),
                       N_obs = nrow(output_df_unk_serum),
                       dilution_factor = 1/output_df_unk_serum$Dilution_factor,
                       ind_sample = output_df_unk_serum$ID,
                       absorb_obs = output_df_unk_serum$Abs,
                       ind_plate_obs = output_df_unk_serum$plate_ID_int)

stan_data_DBS = list(K_plates=max(std_data$plate_ID_int),
                     N_sample = max(output_df_unk_DBS$ID),
                     N_obs = nrow(output_df_unk_DBS),
                     dilution_factor = 1/output_df_unk_DBS$Dilution_factor,
                     ind_sample = output_df_unk_DBS$ID,
                     absorb_obs = output_df_unk_DBS$Abs,
                     ind_plate_obs = output_df_unk_DBS$plate_ID_int)
## stage 1
if(RE_RUN){
  mod_standards = stan_model(file = 'standard_curve_estimation_ELISA_noRE.stan')
  standard_curve = sampling(mod_standards, stan_data_controls, iter=2000, chain=4, thin=20)
  save(standard_curve, file = 'Outputs/standard_curve_fit.RData')
} else {
  load(file = 'Outputs/standard_curve_fit.RData')
}
rstan::traceplot(standard_curve, pars = c('beta','sigma'))

par(las=1, mfrow=c(2,2))
plot(jitter(std_data$true_conc)/200, std_data$Abs,panel.first=grid(),
     xlab='True concentration', ylab='Absorbance at 450 nm',
     ylim = c(0,3), xlim=c(0,1))
betas=rstan::extract(standard_curve, pars='beta')$beta
beta_plates = apply(rstan::extract(standard_curve, pars='beta_plate')$beta_plate,2:3,mean)
for(i in 1:nrow(beta_plates)){
  lines((0:200)/200, log_logistic(beta = beta_plates[i,],x = (0:200)/200))
}
lines((0:200)/200, log_logistic(beta = colMeans(betas),x = (0:200)/200),col='red',lwd=3)

# g_s = rstan::extract(standard_curve,pars='g_controls')$g_controls
# plot(jitter(stan_data_controls$conc_controls), 
#      colMeans(g_s)-stan_data_controls$absorb_controls,
#      panel.first=grid(),ylim=c(-1,1))

tau_controls = colMeans(rstan::extract(standard_curve, pars='tau_controls')$tau_controls)
# plot(stan_data_controls$conc_controls, tau_controls*0.126623)


## stage 2 ********
#********* SERUM
stan_data_serum$beta = colMeans(betas)
stan_data_serum$sigma = mean(rstan::extract(standard_curve,pars='sigma')$sigma)
if(RE_RUN){
  mod_unknowns = stan_model(file = 'serology_estimation_stage2.stan')
  serum_fit = sampling(mod_unknowns, stan_data_serum, iter=2000,
                       chain=4, thin=1,
                       pars=c('g_unk','tau_unk'), 
                       include=FALSE)
  save(serum_fit, file = 'Outputs/serum_fit.RData')
} else {
  load(file = 'Outputs/serum_fit.RData')
}
# traceplot(serum_fit)


#********* DBS
stan_data_DBS$beta = colMeans(betas)
stan_data_DBS$sigma = mean(rstan::extract(standard_curve,pars='sigma')$sigma)
if(RE_RUN){
  mod_unknowns = stan_model(file = 'serology_estimation_stage2.stan')
  DBS_fit = sampling(mod_unknowns, stan_data_DBS, iter=2000,
                     chain=4, thin=1,
                     pars=c('g_unk','tau_unk'), 
                     include=FALSE)
  save(DBS_fit, file = 'Outputs/DBS_fit.RData')
} else {
  load(file = 'Outputs/DBS_fit.RData')
}
# traceplot(DBS_fit)



## extract estimates
# SERUM
log_x_vals = rstan::extract(serum_fit, pars='log_x_init')$log_x_init
log_IgG_ests = data.frame(t(apply(log_x_vals, 2, function(x) c(mean(x), sd(x)))))
colnames(log_IgG_ests) = c('Mean_log_IgG_serum', 'SE_IgG_serum')
log_IgG_ests$ID = 1:nrow(log_IgG_ests)
ind_data = sort(unique(stan_data_serum$ind_sample))
log_IgG_ests = log_IgG_ests[ind_data, ]

res_unique = merge(res_unique, log_IgG_ests, by='ID', all=T)
res_unique$Mean_log_IgG_serum = (res_unique$Mean_log_IgG+log(200)+log(50))/log(10)

# DBS
log_x_vals = rstan::extract(DBS_fit, pars='log_x_init')$log_x_init
log_IgG_ests = data.frame(t(apply(log_x_vals, 2, function(x) c(mean(x), sd(x)))))
colnames(log_IgG_ests) = c('Mean_log_IgG_DBS', 'SE_IgG_DBS')
log_IgG_ests$ID = 1:nrow(log_IgG_ests)
ind_data = sort(unique(stan_data_DBS$ind_sample))
log_IgG_ests = log_IgG_ests[ind_data, ]

res_unique = merge(res_unique, log_IgG_ests, by='ID', all=T)
res_unique = res_unique%>%
  arrange(Subject_ID, Timepoint)
res_unique$Mean_log_IgG_DBS = (res_unique$Mean_log_IgG_DBS+log(200)+log(50))/log(10)

table(serum_available = !is.na(res_unique$Mean_log_IgG_serum),
      DBS_available = !is.na(res_unique$Mean_log_IgG_DBS))

ylim_max = max(c(max(res_unique$SE_IgG_serum,na.rm = T), 
                 max(res_unique$SE_IgG_DBS,na.rm = T)))

xlims = range(c(range(res_unique$Mean_log_IgG_serum,na.rm = T), 
                range(res_unique$Mean_log_IgG_serum,na.rm = T)))

plot(res_unique$Mean_log_IgG_serum,
     res_unique$SE_IgG_serum,
     panel.first=grid(), ylim=c(0, ylim_max),xlim=xlims,
     xlab='Mean serum based estimate (log10)',
     ylab = 'Standard error on serum estimate (log)')

plot(res_unique$Mean_log_IgG_DBS,
     res_unique$SE_IgG_DBS, xlim=xlims,
     panel.first=grid(), ylim=c(0, ylim_max),
     xlab='Mean DBS based estimate (log10)',
     ylab = 'Standard error on DBS estimate (log)')

plot(res_unique$Mean_log_IgG_serum, res_unique$Mean_log_IgG_DBS,
     panel.first=grid(),
     xlab='Mean Serum based estimate (log10)',
     ylab='Mean DBS based estimate (log10)')
lines(0:10, 0:10, col='red',lwd=3)


ind = res_unique$Mean_log_IgG_serum>4 & 
  res_unique$SE_IgG_serum>0.2&
  res_unique$Mean_log_IgG_serum<4.5
View(output_df_unk_serum %>% filter(ID_patient_timepoint %in% res_unique$ID_patient_timepoint[ind]))
sero_main = read_csv('Outputs/serology_outcomes.csv')


paired = output_df_unk_serum %>% group_by(Subject_ID) %>%
  mutate(include = sum(Timepoint==90)>0 & sum(Timepoint==0)>0) %>%
  distinct(Subject_ID, Timepoint, .keep_all = T) %>% arrange(Subject_ID, Timepoint) %>%
  filter(include)

paired = merge(paired, res_unique[, c('Subject_ID','Timepoint',
                                       "Mean_log_IgG_serum","SE_IgG_serum")],
               by = c('Subject_ID','Timepoint'))
paired = paired %>% group_by(Subject_ID) %>%
  mutate(D0_val = Mean_log_IgG_serum[Timepoint==0],
         D90_val = Mean_log_IgG_serum[Timepoint==90],
         ratio = D90_val-D0_val) %>% distinct(Subject_ID, .keep_all = T)

hist(paired$D0_val)

sero_main = sero_main%>%filter(subjectno %in% paired$Subject_ID)


paired = paired %>% 
  mutate(outcome_v2 = case_when(
    D0_val < log10(1250) & D90_val >= log10(1250) & ratio >= log10(4) ~ 'Binary seroconversion and 4-fold rise',
    D0_val < log10(1250) & D90_val >= log10(1250) & ratio < log10(4) ~ 'Binary seroconversion and no 4-fold rise',
    D0_val > log10(1250) & ratio >= log10(4)  ~ 'Baseline ab positive with 4-fold rise'
  ))

paired = merge(paired, sero_main[, c('subjectno','outcome')], by.x='Subject_ID', by.y = 'subjectno')

table(WATSON=paired$outcome_v2,SEAC = !is.na(paired$outcome))

