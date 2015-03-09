# taiga-docker

This Image Don't offer Nginx, need use a nginx container, like this:

``` bash
docker run -d -p 80:80 -v /etc/nginx/conf.d/:/etc/nginx/conf.d:ro --name nginx --link taigadocker_web_1:io.taiga.api --volumes-from taigadocker_web_1  dockerfile/nginx
```

### Deploy

##### Project Config
``` bash
cp backend/settings/local.example.py backend/settings/local.py
cp front/dist/js/conf.example.json front/dist/js/conf.json
```

##### Ngint Config
```
mkdir -p /etc/nginx/conf.d
cp nginx/default.conf /etc/nginx/conf.d/default.conf
```

After, modify config file example.com to your domain.

### Generate Base Data
``` bash
docker-compose run --rm web python manage.py migrate --noinput
docker-compose run --rm web python manage.py loaddata initial_user
docker-compose run --rm web python manage.py loaddata initial_project_templates
docker-compose run --rm web python manage.py loaddata initial_role
```
