#!/usr/bin/env bash

# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#   http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

set -ex

# Fail fast for code linting issues
mkdir $TRAVIS_BUILD_DIR/cpp/lint
pushd $TRAVIS_BUILD_DIR/cpp/lint

cmake ..
make lint

popd

# Fail fast on style checks
sudo pip install flake8

PYARROW_DIR=$TRAVIS_BUILD_DIR/python/pyarrow

flake8 --count $PYARROW_DIR

# Check Cython files with some checks turned off
flake8 --count --config=$PYTHON_DIR/.flake8.cython \
       $PYARROW_DIR
