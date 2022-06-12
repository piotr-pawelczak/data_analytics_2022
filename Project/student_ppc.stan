data {
  int N;
  vector[N] area;
  array[N] real price;
}

parameters {
  real alpha;
  real beta;
  real<lower=0> sigma;
  real<lower=0> nu;
}

transformed parameters {
  vector[N] mu = area * beta + alpha;
}

model {
  nu ~ gamma(2, 0.1);
  alpha ~ student_t(nu, 3500, 500);
  beta ~ lognormal(3, 1);
  sigma ~ exponential(0.005);
  price ~ student_t(nu, mu, sigma);
}

generated quantities {
  array[N] real price_pred;
  for (i in 1:N) {
    price_pred[i] = student_t_rng(nu, mu[i], sigma);
  }
}