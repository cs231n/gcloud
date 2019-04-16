#!/usr/bin/env bash

echo Running CS231n setup ...
jupyter notebook --generate-config
cp -f ./jupyter_notebook_config.py ~/.jupyter/
echo Please set a password for your Jupyter notebook
python -m notebook.auth password
sudo chmod -R 777 /opt
echo Installing Tensorflow 2.0 ...
pip install tensorflow-gpu==2.0.0-alpha0
echo Setup finished.
