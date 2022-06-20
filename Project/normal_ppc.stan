data {
    int N;
    array[N] real area;
}


generated quantities {
    // Priors
   real alpha = normal_rng(3500, 500); // Expected value
   real beta = lognormal_rng(3, 1); // Slope
   real sigma = exponential_rng(0.005);
   array[N] real price;

   for (i in 1:N) {
    price[i] = normal_rng(area[i]*beta + alpha, sigma);
   }
}