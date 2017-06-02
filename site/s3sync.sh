#!/usr/bin/env bash
cd site
hugo
cd ././public/
aws s3 sync --acl "public-read" --sse "AES256" . s3://thoeni --exclude 'post'