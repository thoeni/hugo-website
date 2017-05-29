#!/bin/bash
cd site
hugo
cd ././public/
rsync -avz . ec2-user@thoeni.io:/usr/share/nginx/html/
