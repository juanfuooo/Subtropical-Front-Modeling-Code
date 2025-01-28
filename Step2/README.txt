In step 2, we are going to:

The step 2 will be run on NCI GPU instance (one Nvidia V100) for acceleration.

Apply the XGBoost algorithm to construct a daily Sea Surface Temperature & Sea Temperature at 100m model.

1. Unify the ST100 and SST data into a long format array.

2. Randomly select 15 years training data and 5 years testing data.

3. Set a set of initial hyperprameters and build the xgboost model

4. Tune the hyperparameters by 4-fold cross validation
