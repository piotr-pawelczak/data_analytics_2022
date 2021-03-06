data {
    int N;
    array[N] real area;
}


generated quantities {
    // Priors
   real nu = gamma_rng(2, 0.1);
   real alpha = student_t_rng(nu, 3500, 500); // Expected value
   real beta = lognormal_rng(3, 1); // Slope
   real sigma = exponential_rng(0.005);
   array[N] real price;

   for (i in 1:N) {
    price[i] = student_t_rng(nu, area[i]*beta + alpha, sigma);
   }
}