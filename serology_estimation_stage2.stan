functions {
  real log_logistic(vector beta, real x){
    real y;
    y = exp(beta[1]) + exp(beta[2]) /  (1 + (x / exp(beta[3])) ^ (- exp(beta[4])));
    return(y);
  }
}

data {
  int<lower=0> K_plates;                            // number of plates used
  
  vector[4] beta; 
  real<lower=0> sigma;
  
  // Unknown concentrations data
  int<lower=0> N_sample;                            // number of unique samples
  int N_obs;                                        // number of observations
  vector<lower=0>[N_obs] dilution_factor;           // dilution factor for each observation relative to original
  int<lower=1,upper=N_sample> ind_sample[N_obs];    // index giving unique sample ID
  vector<lower=0>[N_obs] absorb_obs;                // observed absorbance values
  int<lower=1,upper=K_plates> ind_plate_obs[N_obs]; // plate index for each observation
}

// model parameters
parameters {
  // unknown concentrations
  real lambda;
  real log_x_pop_mean;
  real log_x_pop_sigma;
  vector[N_sample] log_x_init;
}

// compute expected absorbance and variance values
transformed parameters {
  vector<lower=0>[N_obs] g_unk;             // expected absorbance in unknowns
  vector<lower=0>[N_obs] tau_unk;           // sqrt of variance of expected absorbance in unknowns
  
  // compute expected/var absorbance values for the unknowns
  for (i in 1:N_obs){
    // expected absorbance value
    g_unk[i] = log_logistic(beta, exp(log_x_init[ind_sample[i]]) * dilution_factor[i]);  
    // sqrt of variance
    tau_unk[i] = g_unk[i] * sigma * exp(lambda);
  }
}

model {
  // ******* Priors **********
  log_x_pop_mean ~ normal(0,1);
  log_x_pop_sigma ~ normal(1,1) T[0,];
  log_x_init ~ normal(log_x_pop_mean,log_x_pop_sigma);
  lambda ~ normal(0,1);
  
  // ******* LIKELIHOOD **********
  // Likelihood for the unknown samples data
  absorb_obs ~ normal(g_unk, tau_unk);
}
