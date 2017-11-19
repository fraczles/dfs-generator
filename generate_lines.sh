#!/usr/bin/env bash

set -ex

OPTIMIZER_SCRIPT="https://raw.githubusercontent.com/fraczles/dfs-generator/master/optimizer.jl"

DOCKER_IMAGE="fraczles/julia:glpk"

curl "$OPTIMIZER_SCRIPT" > ./optimizer.jl
chmod +x ./optimizer.jl


# Pull skaters.csv from S3
aws s3 cp s3://picking-winners/skaters.csv .
aws s3 cp s3://picking-winners/goalies.csv .

# Pull goalies.csv from S3

docker run --rm -it -v \
  "$PWD":/usr/myapp "$DOCKER_IMAGE" \
  julia /usr/myapp/optimizer.jl

aws s3 mv ./new_output.csv s3://picking-winners/output.csv
