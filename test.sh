#!/bin/bash

DJ_VERSION=$(django-admin.py --version)

# exit if fail
[[ "$?" -ne "0" ]] && exit;

IS_16_OR_17=$(echo $DJ_VERSION | grep -e "1.[67]")

# if django version is not 1.6 (non-0 exit) we have to pass different
# app names to test runner
if [ "$?" -ne "1" ]; then
    app_names=( provider provider.oauth2 )
else
    app_names=( provider oauth2 )
fi

python manage.py test ${app_names[@]} --traceback --failfast
