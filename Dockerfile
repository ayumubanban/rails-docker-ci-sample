FROM ruby:2.6.3
ENV LANG C.UTF-8
ENV APP_ROOT /sample
RUN apt-get update -qq && apt-get install -y --no-install-recommends \
    build-essential \
    nodejs \
    && rm -rf /var/lib/apt/lists/* \
    && gem install bundler \
    rails:5.2.3 \
    nokogiri \
    pg:1.1.4
WORKDIR $APP_ROOT
COPY Gemfile Gemfile.lock $APP_ROOT/
RUN bundle install
COPY . $APP_ROOT
ENV RAILS_SERVE_STATIC_FILES=1
EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]