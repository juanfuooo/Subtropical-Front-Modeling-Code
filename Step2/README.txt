In step 2, we are going to:

We run the model on NCI GPU instance (one Nvidia V100) for acceleration (X100 times faster than the 28-core CPU instance). 
To use the GPU instance, we have to set up our own environment on NCI.
(https://opus.nci.org.au/spaces/Help/pages/175538441/3.3+Using+a+custom+Python+virtual+environment+in+JupyterLab#:~:text=Creating%20the%20venv%201%20Log%20into%20Gadi%2C%20and,...%204%20Update%20the%20pip%20and%20setuptools%20packages%3A).

Apply the XGBoost algorithm to construct a monthly Sea Surface Temperature & Sea Temperature at 100m model.

1. Unify the ST100 and SST data into the long format (panda dataframe).

2. Randomly select 15 years training data and 5 years testing data (whole year randomly seletion).

3. Set a set of initial hyperprameters and build the xgboost model.

4. Tune the hyperparameters by 4-fold cross validation (partially).
