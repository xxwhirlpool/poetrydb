FROM ruby:3.3.9-slim-bookworm
RUN apt-get update
RUN apt-get install -y gnupg curl

RUN curl -fsSL https://www.mongodb.org/static/pgp/server-7.0.asc | \
	gpg -o /usr/share/keyrings/mongodb-server-7.0.gpg \
	--dearmor
RUN echo "deb [ signed-by=/usr/share/keyrings/mongodb-server-7.0.gpg ] \ 
	http://repo.mongodb.org/apt/debian bookworm/mongodb-org/7.0 main" \
	| tee /etc/apt/sources.list.d/mongodb-org-7.0.list

RUN apt update
RUN apt install -y mongodb-org build-essential

RUN mkdir /poetrydb
COPY ./ /poetrydb
WORKDIR /poetrydb/app
RUN rm Gemfile.lock
RUN bundle install
