#!/bin/bash

pip=$(which pip || which pip3)

$pip install awscli --ignore-installed six
