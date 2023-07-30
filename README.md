# OBJECTIVE

This repository consists of files designed to investigate the sympathetic phenomena of an electrical system. 

# HOW TO USE

It has a SIMULINK model (sympathetic_trip.slx) with a description of a chosen electrical system. "generate_dataset.m" MATLAB script should be used to design an automatic implementation of an experiment and generate a preliminary set of data. "transform_and_convert_dataset.m" MATLAB script should be used when the implementation of the "generate_dataset.m" script is over and the preliminary dataset exists. "transform_and_convert_dataset.m" script assemble separated data files from different experiments and converts it into "train_dataset.h5" and "test_dataset.h5" datasets (examples of those files can be uploaded from [KAGGLE](https://www.kaggle.com/datasets/nikolaigalkin/sympathetic-trip)). Finally, "generate_verification_dataset.m" MATLAB script should be used to generate one additional dataset with the purpose of supervised neural network verification.

# Disclaimer
Please note that all files provided in this repository should be considered as "it is". To adjust both the SIMULINK model and provided MATLAB scripts to your personal goals, some significant (or insignificant) changes may be necessary.

# Requirements
MATLAB version 2019b or later.
