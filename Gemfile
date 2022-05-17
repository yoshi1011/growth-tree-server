source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.1'

# base
gem 'rails', '~> 6.1.5'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'bootsnap', '>= 1.4.4', require: false
# 出力するJSONを定義
gem 'jbuilder'
# CORS対応
gem 'rack-cors'

# ログイン認証
gem 'devise', '~> 4.8'
gem 'devise_token_auth', '~> 1.2'

# Ruby 3.1系でnet-smtp外部化の影響に対する対策
# https://qiita.com/jnchito/items/4ef331281f0050428716
gem 'net-smtp'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails', '~> 5.0.0'
  gem 'spring-commands-rspec'
  gem 'factory_bot', '~> 6.2.0'
end

group :development do
  gem 'listen', '~> 3.3'
  gem 'spring'
  gem 'annotate'
  gem 'rubocop-rails', require: false
end

group :test do
  gem 'shoulda-matchers', '~> 5.0'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
