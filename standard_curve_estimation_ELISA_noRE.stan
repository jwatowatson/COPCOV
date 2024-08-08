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
}

// model parameters
parameters {
  // standard curve and error terms
  vector[4] beta;                        // standard curve population parameters
  real<lower=0> sigma;                   // measurement error sd term
  // re single
  vector[K_plates] theta_2;
  real sigma_re;
}

// compute expected absorbance and variance values
transformed parameters {
  vector<lower=0>[N_controls] g_controls;   // expected absorbance in controls
  vector<lower=0>[N_controls] tau_controls; // sqrt of variance of expected absorbance in controls
  vector[4] beta_plate[K_plates];           // plate individual parameters for standard curve
  for(k in 1:K_plates){
    beta_plate[k]=beta;
    beta_plate[k][2] += theta_2[k];
  }
  // compute expected/var absorbance values for the controls
  for (i in 1:N_controls) {
    // expected absorbance value
    g_controls[i] = log_logistic(beta, conc_controls[i]);  
    // sqrt of variance
    tau_controls[i] = g_controls[i] ;
  }
}

model {
  // ******* Priors **********
  
  beta[1] ~ normal(-2, 0.5);
  beta[2] ~ normal(1.3, 0.25);
  beta[3] ~ normal(-0.5, 0.5);
  beta[4] ~ normal(.5, 0.25);
  
  sigma ~ normal(.1, .1);
  
  theta_2 ~ normal(0, sigma_re);
  sigma_re ~ normal(0,.1) T[0,];
  
  // ******* LIKELIHOOD **********
  // Likelihood for the control data
  absorb_controls ~ normal(g_controls, tau_controls * sigma);
}
