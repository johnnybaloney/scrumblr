# run with:
# $ docker run -d -p 80:80 -v /absolute/path/to/scrumblr:/scrumblr

FROM bitnami/minideb:stretch

RUN apt update
RUN apt -y install git curl redis-server procps
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash -
RUN apt -y install nodejs
RUN sed -i 's/^appendonly no/appendonly yes/' /etc/redis/redis.conf
# download node modules to /node_modules
COPY package.json /
RUN npm install
WORKDIR /scrumblr
EXPOSE 80
ENTRYPOINT nohup bash -c "redis-server /etc/redis/redis.conf &" && nohup bash -c "node server.js --server:port=80"
