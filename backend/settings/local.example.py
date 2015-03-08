from .common import *

DATABASES = {
    "default": {
        "ENGINE": "transaction_hooks.backends.postgresql_psycopg2",
        "NAME": "taiga",
        "HOST": 'db',
        "USER": 'taiga',
        "PASSWORD": 'taiga',
        "PORT": '5432',
    }
}

MEDIA_URL = "http://example.com/media/"
STATIC_URL = "http://example.com/static/"
ADMIN_MEDIA_PREFIX = "http://example.com/static/admin/"
SITES["front"]["scheme"] = "http"
SITES["front"]["domain"] = "example.com"

SECRET_KEY = "theveryultratopsecretkey"

DEBUG = False
TEMPLATE_DEBUG = False
PUBLIC_REGISTER_ENABLED = True

DEFAULT_FROM_EMAIL = "no-reply@example.com"
SERVER_EMAIL = DEFAULT_FROM_EMAIL

# Async Task Setting
from .celery import *

BROKER_URL = 'amqp://guest:guest@localhost:5672//'
CELERY_RESULT_BACKEND = 'redis://localhost:6379/0'
CELERY_ENABLED = True
