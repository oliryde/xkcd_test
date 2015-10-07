FROM alpine:3.2

RUN apk update && apk --update add ruby

RUN apk --update add --virtual build-dependencies build-base ruby-dev openssl-dev

RUN gem install --no-ri --no-rdoc sinatra oga

ENV RACK_ENV production

ADD . /app
RUN chown -R nobody:nogroup /app
WORKDIR /app
CMD ["ruby", "test.rb"]