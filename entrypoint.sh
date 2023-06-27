cd /pigeon_general_atomics
if [ ! -d "logs" ]; then
  mkdir -p /pigeon_general_atomics/logs
  touch logs/debug.log
  touch logs/django_request.log
fi

apt update
apt install python-is-python3 -y

if [ ${CELERY} == "True" ]; then
    celery -A pigeon_general_atomics worker --loglevel=debug
else
  rm -rf staticfiles/*
  mkdir staticfiles
  python manage.py collectstatic
  chmod +x temp_recreate_db.sh
  ./temp_recreate_db.sh
  python manage.py runserver 0.0.0.0:8234
fi
