FROM python:3
MAINTAINER nsdont "haodewanan@gmail.com"

RUN apt-get -qq update

RUN apt-get install --no-install-recommends -y -q  nodejs npm
RUN apt-get install -y python-dev python-setuptools git-core locales
RUN gem install sass scss-lint
RUN npm install -g gulp bower
RUN ln -s /usr/bin/nodejs /usr/bin/node

RUN echo "LANG=en_US.UTF-8" > /etc/default/locale
RUN echo "LC_MESSAGES=POSIX" >> /etc/default/locale
RUN echo "LANGUAGE=en" >> /etc/default/locale
RUN locale-gen en_US.UTF-8
ENV LANG en_US.UTF-8

RUN mkdir /taiga
WORKDIR /taiga

# install taiga front
RUN git clone https://github.com/taigaio/taiga-front.git front
WORKDIR /taiga/front
RUN npm install
RUN bower install --allow-root
RUN gulp deploy

# install taiga back
RUN git clone https://github.com/taigaio/taiga-back.git backend
WORKDIR /taiga/backend
RUN pip install -r requirements.txt
RUN python manage.py collectstatic --noinput

RUN (echo "alias ll='ls -atrhlF'" >> ~/.bashrc)

VOLUME ["/logs", "/taiga"]

EXPOSE 8001

CMD ["python", "manage.py", "runserver", "0.0.0.0:8001"]
