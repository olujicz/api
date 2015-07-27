#!/bin/bash

export C_FORCE_ROOT=yes
export FLASK_CONFIG=dev

pip install -U -r requirements.txt
pip install -U -r requirements_dev.txt
consul-template -once -config /usr/src/app/consul/onelove.conf
celery -A manage.celery worker --workdir /usr/src/app --loglevel INFO --pidfile /run/celery.pid --autoreload &
sleep 2
python manage.py runserver