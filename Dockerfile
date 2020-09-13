FROM ruby:2.6.3

RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs \
  npm
  
RUN npm install -g yarn

WORKDIR /recipes_drawer
COPY Gemfile* ./
RUN gem install bundler:2.1.4
RUN bundle install
COPY . ./

RUN yarn install

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]


CMD ["bundle", "exec", "rails", "server", "-p", "9000"]