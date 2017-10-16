#!/usr/bin/env bash

tar czvf simple-sinatra-app-0.0.1.tar.gz simple-sinatra-app/*
tar czvf config-0.0.1.tar.gz ansible/* scripts/* tests/*

aws s3 cp simple-sinatra-app-0.0.1.tar.gz s3://duy-site/simple-sinatra-app/
aws s3 cp config-0.0.1.tar.gz s3://duy-automation/simple-sinatra-app/
