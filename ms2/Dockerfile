FROM ruby:2.1.5
RUN apt-get update -y
RUN gem install bundler -v 1.12.5 --no-ri --no-rdoc

RUN mkdir -p /app
WORKDIR /app

# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile Gemfile.lock ./

RUN bundle install --retry 5

# Copy the main application.
COPY . ./

ENV MS_URL=ms2-master.example.com
ENV PORT=3000
EXPOSE 3000

#start puma
CMD ruby web.rb -s Puma