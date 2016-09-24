FROM node


RUN  apt-get update && apt-get install -y apt-transport-https && apt-get -y install nginx

RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

EXPOSE 80

WORKDIR /app

COPY ./package.json /app/
COPY ./bower.json /app/
RUN npm install

COPY . /app/

RUN npm run build

RUN cp -R /app/dist/*  /usr/share/nginx/html

CMD /app/docker-entrypoint.sh
