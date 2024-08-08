library(tidyverse)
library(readxl)
library(stringr)
path1 ='Data/Serology/450 nm/'
path2 ='Data/Serology/450 and 620 nm/'

f_meta ='Data/Serology/COPCOV Sample List_modified.xlsx'



###########################################################################################
################################## GET META DATA ##########################################
all_sheets = readxl::excel_sheets(f_meta)
dat_list = list()

for(my_sh in all_sheets){
  
  writeLines(sprintf('Doing sheet %s',my_sh))
  xx=suppressMessages(unlist(readxl::read_excel(path = f_meta, sheet = my_sh, skip = 0,n_max = 1,col_names = F,)))
  print(xx)
  
  plate_id = str_pad(as.numeric(str_match(xx, "\\(\\s*(.*?)\\s*\\)")[2]), width = 3, pad = '0',side = 'left')
  dat = suppressMessages(readxl::read_excel(path = f_meta, sheet = my_sh, skip=1))
  
  writeLines(sprintf('There are %s rows in this data file', nrow(dat)))
  
  ## GET THE COLUMNS WE WANT
  colnames(dat) = tolower(colnames(dat))
  colnames(dat)[1]='un_ID'
  
  ind = grep(pattern = 'sample', x = colnames(dat))
  if(length(ind)>1) stop('sample column??')
  
  if(length(ind)==0){
    dat$sample_type=NA
    if(!'dilution' %in% colnames(dat)){
      print(colnames(dat))
      writeLines('************* NO SAMPLE/OR DILUTION INFO *************')
      stop()
    }
  } else {
    colnames(dat)[ind]='sample_type'
  }
  
  if(!"dilution" %in% colnames(dat)){
    print(colnames(dat))
    writeLines('************* NO DILUTION DATA FOR THIS SHEET *************')
    dat$dilution = NA
  }
  
  ind = grep(pattern = 'subject', x = colnames(dat))
  if(length(ind) != 1) {
    print(my_sh)
    stop('whoops - where is subject no?')
  }
  colnames(dat)[ind]='Subject_ID'
  for(kk in 1:(nrow(dat)-1)){
    id_current = dat$Subject_ID[kk]
    if(is.na(dat$Subject_ID[kk+1])) dat$Subject_ID[kk+1]=id_current
  }
  
  ind = grep(pattern = 'time', x = colnames(dat))
  if(length(ind) != 1) {
    print(my_sh)
    stop('whoops - where is time-point column?')
  }
  colnames(dat)[ind]='Timepoint'
  
  dat = dat[, c('un_ID','Subject_ID','Timepoint','dilution','sample_type')]
  dat$un_ID = paste0('un', str_pad(dat$un_ID, width = 3, pad = '0',side = 'left'))
  dat$plate_ID = paste('plate', as.numeric(plate_id), sep = '_')
  
  ## check dilution
  dat$dilution = ifelse(dat$dilution=='1 in 400','1:400', dat$dilution)
  dat$dilution = ifelse(dat$dilution=='1 in 50','1:50', dat$dilution)
  if(any(!dat$dilution %in% c(NA,'1:50','1:400'))){
    writeLines(sprintf('odd dilutions in sheet %s', my_sh))
  }
  
  dat_list[[which(my_sh==all_sheets)]]=dat
}

for(i in 1:length(dat_list)){
  print(c(i, nrow(dat_list[[i]]), ncol(dat_list[[i]])))
}
meta_dat_all = do.call("rbind", dat_list) 
apply(meta_dat_all, 2, function(x) sum(is.na(x)))

# this removes test samples (DBS - not from patients)
meta_dat_all = meta_dat_all%>% filter(!is.na(Timepoint))
unique(meta_dat_all$Timepoint)
meta_dat_all$Timepoint[meta_dat_all$Timepoint %in% c('d0H0','D00','D0H0','D0')]='0'
xx = as.numeric(meta_dat_all$Timepoint)
meta_dat_all$Timepoint[!is.na(xx) & xx>80]=90
meta_dat_all$Timepoint[meta_dat_all$Timepoint == 'D90']='90'
meta_dat_all$Timepoint[meta_dat_all$Timepoint == 'D30']='30'
meta_dat_all$Timepoint[meta_dat_all$Timepoint == 'D60']='60'
meta_dat_all$Timepoint = as.numeric(gsub(pattern = 'D',replacement = '',x = meta_dat_all$Timepoint))

table(is.na(meta_dat_all$Timepoint))

meta_dat_all = meta_dat_all %>% filter(!is.na(Timepoint))

# consistently label all serum samples
meta_dat_all$sample_type[grep(pattern = 'serum',ignore.case = T,x = meta_dat_all$sample_type)]='serum'

# approximate dilution factor for DBS is thought to be 1:66 based on volumes used
meta_dat_all$dilution[is.na(meta_dat_all$dilution) & meta_dat_all$sample_type=='DBS']='1:66'
meta_dat_all$sample_type[!is.na(meta_dat_all$dilution) &
                           meta_dat_all$dilution %in% c('1:400','1:50') &
                           is.na(meta_dat_all$sample_type)]='serum'

table(dilution = meta_dat_all$dilution, sample_type = meta_dat_all$sample_type, useNA = 'ifany')

unique(meta_dat_all$plate_ID[ is.na(meta_dat_all$sample_type) | is.na(meta_dat_all$dilution)])
apply(meta_dat_all, 2, function(x) sum(is.na(x)))

###############**************************** GET RAW DATA **********************************
###############*###########################################################################
plate_data_list1=plate_data_list2=list()
f_names = list.files(path = path1, pattern=".csv")
f_names2 = list.files(path = path2, pattern=".csv")

## Extract Reading 1
for(i in 1:length(f_names)) {
  plate_ID=as.numeric(strsplit(gsub(pattern = 'CPVTFC3SG',replacement = '',x = f_names[i]),split = '_')[[1]][1])
  plate_data <- suppressMessages(read_csv(paste(path1, f_names[i], sep=""), col_names = TRUE, skip = 9))
  plate_data = plate_data %>% filter(!is.na(Abs))
  plate_data$plate_ID = paste('plate', plate_ID,sep='_')
  plate_data$order_reading = 1:nrow(plate_data)
  plate_data_list1[[i]] = plate_data
}
output_df1 <- do.call("rbind", plate_data_list1)

## Extract Reading 2
for(i in 1:length(f_names2)) {
  plate_ID=as.numeric(strsplit(gsub(pattern = 'CPVTFC3SG',replacement = '',x = f_names2[i]),split = '_')[[1]][1])
  # plate_ID = (strsplit(f_names[i], "\\_|\\."))[[1]][1]
  plate_data <- suppressMessages(read_csv(paste(path2, f_names2[i], sep=""), col_names = TRUE, skip = 9))
  plate_data = plate_data %>% filter(`Wavelength [Ex]`== 450, !is.na(Abs))
  plate_data$plate_ID = paste('plate', plate_ID,sep='_')
  plate_data$order_reading = 1:nrow(plate_data)
  plate_data_list2[[i]] = plate_data
}
output_df2 <- do.call("rbind", plate_data_list2)

output_df = merge(output_df1, output_df2, 
                  by = c("Well","Group","Type","Sample",
                         "Wavelength [Ex]",
                         "plate_ID",'order_reading'), all = T)

output_df = output_df %>% filter(Type !='Blank')
output_df$Well_row = as.numeric(gsub(pattern = '[A-Z]', replacement = '',x = output_df$Well))
output_df$Well_col = (gsub(pattern = '[0-9]', replacement = '',x = output_df$Well))
output_df$Time_1 = output_df$`Time [s].x`
output_df$Time_2 = output_df$`Time [s].y`
std = output_df %>% filter(Type=='Standard')
unk = output_df %>% filter(Type=='Unknown')



####
# Look at high value in first reading only
# library(mgcv)
# mod_std = lm(log(Abs.x)-log(Abs.y) ~ Time_2+Well, data = std)
# summary(mod_std)
# plot(std$Abs.x, mod_std$residuals)
# mod_std = lm(log(Abs.y) ~ offset(log(Abs.x))+Time_2+Well+plate_ID, data = std)
# xx=summary(mod_std)
# xx
# plot(log(std$Abs.x), xx$residuals)
# plot(coef(mod)[-1])
# plot(log(output_df$Abs.y), predict(mod)-log(output_df$Abs.x))
# 
# plot(log(unk$Abs.x), -log(unk$Abs.y),
#      xlab='Reading 1 (log OD)', ylab='Reading 2 (log OD)',
#      panel.first=grid(), main='controls')
# plot(unk$`Time [s].x`, unk$Abs.x)
# 
# plot(log(std$Abs.x), log(std$Abs.x)-log(std$Abs.y),
#      xlab='Reading 1 (log OD)', ylab='Reading 1 - Reading 2 (log OD)',
#      panel.first=grid(), main='controls')
# plot(log(std$Abs.x), log(std$Abs.y),
#      xlab='Reading 1 (log OD)', ylab='Reading 1 - Reading 2 (log OD)',
#      panel.first=grid(), main='controls')
# plot(unk$`Time [s].y`, log(unk$Abs.x)-log(unk$Abs.y),
#      xlab='Time in seconds (second reading',
#      ylab='Residual between 1st and 2nd reading')
# unk$Time_2 = unk$`Time [s].y`
# library(lme4)
# mod = lmer(formula = Abs.x ~ offset(Abs.x) + Time_2 + (1|plate_ID), data = unk)
# summary(mod)
# unk$pred2=predict(mod, newdata=data.frame(Abs.x=unk$Abs.x, Time_2=0, plate_ID=unk$plate_ID))

# par(mfrow=c(1,2))
# plot(log(output_df$Abs.x), log(output_df$Abs.x)-log(output_df$Abs.y),
#      xlab='Reading 1 (log OD)', ylab='Reading 1 - Reading 2 (log OD)',
#      panel.first=grid(), main='Unknowns', xlim = c(-3.1,1.2), ylim = c(-0.3, 1.2))
# plot(log(std$Abs.x), log(std$Abs.x)-log(std$Abs.y),
#      xlab='Reading 1 (log OD)', ylab='Reading 1 - Reading 2 (log OD)',
#      panel.first=grid(), xlim = c(-3.1,1.2), ylim = c(-0.3, 1.2),
#      main = 'Controls')

# xx=output_df %>% group_by(Well) %>%
#   mutate(diff_1_2 = log(Abs.x)-log(Abs.y),
#          diff_1_2_mean = mean(diff_1_2),
#          diff_1_2_sd = sd(diff_1_2)) %>%
#   distinct(Well, .keep_all = T)
# library(platetools)
# library(viridis)
# platetools::z_map(data = xx$diff_1_2_mean, well = xx$Well,plate = 384)
# raw_map(data = xx$diff_1_2_sd, well = xx$Well,plate = 384)+
#   ggtitle("Mean SD in 384-well plate") +
#   theme_dark() 
# 
# raw_map(data = xx$diff_1_2_mean, well = xx$Well,plate = 384)+
#   ggtitle("Mean values in 384-well plate") +
#   theme_dark() +
#   scale_fill_viridis()
# 
# mod_wells = lm(log(Abs.x)-log(Abs.y) ~ log(Abs.x) + Well + plate_ID, data = output_df)
# preds=predict(mod_wells, newdata = data.frame(Well=unique(output_df$Well),
#                                               plate_ID=output_df$plate_ID[1],
#                                               Abs.x=1))
# raw_map(data = preds, well = unique(output_df$Well),plate = 384)+
#   ggtitle("Mean predicted residual in 384-well plate") +
#   theme_dark() +
#   scale_fill_viridis()
# 
# 
# ind = which(log(output_df$Abs.x)-log(output_df$Abs.y) > 0.3)
# length(ind)
# View(output_df[ind, ])
# 
# output_df$Abs = ifelse(output_df$Abs.x<0.5)
# 
# if(! length(unique(output_df$plate_ID))==length(unique(meta_dat_all$plate_ID))&
#    all(sort(unique(output_df$plate_ID)) == sort(unique(meta_dat_all$plate_ID)))){
#   stop('problem!!!')
# }
# 

# extract the control data
std_data = output_df %>% filter(Type=='Standard') %>% arrange(plate_ID)
std_data$plate_ID_int = as.numeric(as.factor(std_data$plate_ID))
unique(std_data$Sample)
CAL_VALS = c(200,200,150,150,100,100,80,80,40,40,20,20,10,10)
names(CAL_VALS) = c("CAL10001","CAL10002","CAL20001","CAL20002","CAL30001","CAL30002",
                    "CAL40001","CAL40002","CAL50001","CAL50002","CAL60001","CAL60002",
                    "CAL70001","CAL70002")
std_data$true_conc = CAL_VALS[std_data$Sample]


# extract the unknowns data
output_df_unk = output_df %>% filter(Type=='Unknown') %>% arrange(plate_ID)
output_df_unk$Unique_sample_ID = apply(output_df_unk[, c('Sample','plate_ID')], 1, paste, collapse='_')
meta_dat_all$Unique_sample_ID = apply(meta_dat_all[, c('un_ID','plate_ID')], 1, paste, collapse='_')
output_df_unk$Unique_sample_ID=tolower(output_df_unk$Unique_sample_ID)
output_df_unk$plate_ID_int = as.numeric(as.factor(output_df_unk$plate_ID))
output_df_unk$Abs = output_df_unk$Abs.x

output_df_unk = merge(output_df_unk, 
                      meta_dat_all[, c('Subject_ID','Timepoint',
                                       'sample_type','dilution',
                                       'Unique_sample_ID','plate_ID')],
                      by = 'Unique_sample_ID')

output_df_unk = output_df_unk %>% filter(!is.na(dilution))

table(output_df_unk$dilution, output_df_unk$sample_type, useNA = 'ifany')

output_df_unk$Timepoint_Day = paste('D', as.character(output_df_unk$Timepoint), sep = '')
output_df_unk$ID_patient_timepoint = apply(output_df_unk[,c('Subject_ID','Timepoint_Day')],1,paste,collapse='_')
length(unique(output_df_unk$ID_patient_timepoint))

output_df_unk = output_df_unk %>%
  mutate(Dilution_factor = as.numeric(gsub(x=dilution,pattern='1:',replacement=''))/50)
output_df_unk$ID = as.numeric(as.factor(output_df_unk$ID_patient_timepoint))
max(output_df_unk$ID)

save(output_df_unk, std_data, file = 'Data/Serology/serology_all.RDS')
write_csv(output_df_unk, file = 'Data/Serology/serology_unknowns.csv')
write_csv(std_data, file = 'Data/Serology/serology_controls.csv')


