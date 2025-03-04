FROM ruby:3.1.2-alpine
USER root
RUN mkdir test_app
RUN mkdir RoR_app
RUN apk --no-cache add curl
RUN curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl" 
RUN chmod +x kubectl
RUN mv kubectl /usr/local/bin/
RUN apk add apache2
RUN mkdir -p /run/apache2
RUN apk add openrc
RUN openrc
RUN touch /run/openrc/softlevel
RUN rm /var/www/localhost/htdocs/index.html
RUN apk add nano
RUN apk add git
RUN apk add ufw
COPY ./index.html /var/www/localhost/htdocs
COPY ./txt /RoR_app
COPY ./ /test_app
CMD openrc -s apache2 start
CMD service apache2 start
