FROM olegabu/fabric-tools-extended

MAINTAINER shiqinfeng1

# Create app directory
WORKDIR /usr/src/app

## install dependencies
# COPY ["package.json", "package-lock.json"] .
COPY "package.json" .

RUN apt-get update && apt-get install python make  \
&& npm install && npm cache rm --force \
&& apt-get remove -y python make && apt-get purge


RUN git clone https://github.com/shiqinfeng1/fabric-starter-admin-web.git --branch stable --depth 1 admin && npm install aurelia-cli -g && cd admin && npm install
RUN cd admin && au build --env prod

# add project files (see .dockerignore for a list of excluded files)
COPY . .

EXPOSE 3000
CMD [ "npm", "start" ]
