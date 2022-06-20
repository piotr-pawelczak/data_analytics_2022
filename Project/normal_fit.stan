data {
  int N;
  vector[N] area;
  array[N] real price;
}

parameters {
  real alpha;
  real beta;
  real<lower=0> sigma;
}

transformed parameters {
  vector[N] mu = area * beta + alpha;
}

model {
  alpha ~ normal(3500, 500);
  beta ~ lognormal(3, 1);
  sigma ~ exponential(0.005);
  price ~ normal(mu, sigma);
}

generated quantities {
  array[N] real price_pred;
  array[N] real log_lik;

  for (i in 1:N) {
    price_pred[i] = normal_rng(mu[i], sigma);
    log_lik[i] = normal_lpdf(price[i]|mu[i], sigma);
  }
}