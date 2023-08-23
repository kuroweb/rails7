FROM ruby:3.2.2

#===================
# packageセットアップ
#===================
# 最新版のyarnをリポジトリに反映
RUN wget --quiet -O - /tmp/pubkey.gpg https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y \
    nodejs \
    npm \
    default-mysql-client \
    less \
    vim \
    curl \
    sudo

RUN npm i -g n && n 18.4.0

#======================
# プロジェクトセットアップ
#======================
WORKDIR /app

# gem
COPY Gemfile* .
RUN bundle install

# node_modules
COPY package.json .
COPY package-lock.json .
RUN npm i
