functions {
  real log_logistic(vector beta, real x){
    real y;
    y = exp(beta[1]) + exp(beta[2]) /  (1 + (x / exp(beta[3])) ^ (- exp(beta[4])));
    return(y);
  }
}

data {
  int<lower=0> K_plates;                                     // number of plates used
  
  // Control data (standards)
  int<lower=0> N_controls;                                   // number of data points in the controls
  vector<lower=0>[N_controls] conc_controls;                 // known concentration values in controls
  vector<lower=0>[N_controls] absorb_controls;               // observed absorbance values in controls
  int<lower=1,upper=K_plates> ind_plate_controls[N_controls];// plate index for each control measurement
  
  // Unknown concentrations data
  int<lower=0> N_sample;                            // number of unique samples
  int<lower=N_sample> N_obs;                        // number of observations
  vector<lower=0>[N_obs] dilution_factor;           // dilution factor for each observation relative to original
  int<lower=1,upper=N_sample> ind_sample[N_obs];    // index giving unique sample ID
  vector<lower=0>[N_obs] absorb_obs;                // observed absorbance values
  int<lower=1,upper=K_plates> ind_plate_obs[N_obs]; // plate index for each observation
}

// this is for the variance-covariance matrix for the plate random effects

transformed data {
  int K_z = 1;
  vector[K_z] my_zeros;
  for(i in 1:K_z) my_zeros[i] = 0;
}


// model parameters
parameters {
  
  // plate random effects: var-covar matrix
  //cholesky_factor_corr[K_z] L_Omega;     // correlation matrix for control RE across plates
  vector<lower=0>[K_z] sigmasq_u;        // variance of random effects
  vector[K_z] theta_rand[K_plates];       // individual random effects vector
  
  // standard curve and error terms
  vector[4] beta;                        // standard curve population parameters
  real<lower=0> alpha;                   // heteroskedasticity parameter
  real<lower=0> sigma;                   // measurement error sd term
  
  // unknown concentrations
  vector[N_sample] log_x_init;
}

// compute expected absorbance and variance values
transformed parameters {
  vector<lower=0>[N_controls] g_controls;   // expected absorbance in controls
  vector<lower=0>[N_controls] tau_controls; // sqrt of variance of expected absorbance in controls
  vector<lower=0>[N_obs] g_unk;             // expected absorbance in unknowns
  vector<lower=0>[N_obs] tau_unk;           // sqrt of variance of expected absorbance in unknowns
  vector[4] beta_plate[K_plates];           // plate individual parameters for standard curve
  
  for(k in 1:K_plates){
    beta_plate[k]=beta;
    beta_plate[k][2] += theta_rand[k][1];
    //beta_plate[k][3] += theta_rand[k][1];
  }
  
  // compute expected/var absorbance values for the controls
  for (i in 1:N_controls) {
    // expected absorbance value
    g_controls[i] = log_logistic(beta_plate[ind_plate_controls[i]], conc_controls[i]);  
    // sqrt of variance
    tau_controls[i] = (g_controls[i] ^ alpha) * (sigma);
  }
  
  // compute expected/var absorbance values for the unknowns
  for (i in 1:N_obs){
    // expected absorbance value
    g_unk[i] = log_logistic(beta_plate[ind_plate_obs[i]], exp(log_x_init[ind_sample[i]]) * dilution_factor[i]);  
    // sqrt of variance
    tau_unk[i] = (g_unk[i] ^ alpha) * (sigma);
  }
}

model {
  // ******* Priors **********
  alpha ~ normal(1, .5);
  beta[1] ~ normal(-2, 1);
  beta[2] ~ normal(1, 1);
  beta[3] ~ normal(-0.5, 1);
  beta[4] ~ normal(.5, 1);
  
  sigmasq_u[1] ~ normal(.1, .1) T[0,]; 
  //sigmasq_u[2] ~ normal(.12,.1) T[0,]; 
  
  log_x_init ~ normal(3,2);
  
  sigma ~ normal(.1, .05);
  
 // L_Omega ~ lkj_corr_cholesky(2); // covariance matrix - random effects across plates
  
  // individual random effects
  for(i in 1:K_plates) theta_rand[i] ~ normal(0, sigmasq_u[1]);// multi_normal_cholesky(my_zeros, diag_pre_multiply(sigmasq_u, L_Omega));
  
  // ******* LIKELIHOOD **********
  // Likelihood for the control data
  absorb_controls ~ normal(g_controls, tau_controls);
  // Likelihood for the unknown samples data
  absorb_obs ~ normal(g_unk, tau_unk);
}
