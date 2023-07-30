# OBJECTIVE

This repository consists of files designed to investigate the sympathetic phenomena of an electrical system. 

# HOW TO USE

It has a SIMULINK model (sympathetic_trip.slx) with a description of a chosen electrical system. "generate_dataset.m" MATLAB script should be used to design an automatic implementation of an experiment and generate a preliminary set of data. "transform_and_convert_dataset.m" MATLAB script should be used when the implementation of the "generate_dataset.m" script is over and the preliminary dataset exists. "transform_and_convert_dataset.m" script assemble separated data files from different experiments and converts it into "train_dataset.h5" and "test_dataset.h5" datasets (examples of those files are uploaded in the current repository).
