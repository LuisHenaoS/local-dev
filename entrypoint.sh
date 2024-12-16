#!/bin/bash

# https://kinsta.com/es/blog/dockerfile-entrypoint/
# https://gist.github.com/jefftriplett/8ec40a937654f90a65d6886140215ec2
python ./manage.py

exec "$@"