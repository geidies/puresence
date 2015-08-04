FROM ruby:2.2-onbuild
MAINTAINER sgeidies@thoughtworks.com

#COPY . /opt
#WORKDIR /opt
#RUN apt-get install make && \
#    bundle install
ENV RACK_ENV "docker"
EXPOSE 9292
CMD ["rackup"]
