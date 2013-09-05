#coding: utf-8

# requires Gemfile
begin
  require 'bundler'
  Bundler.require(:default, ENV['RACK_ENV'].to_sym)
rescue Bundler::GemNotFound => e
  STDERR.puts e.message
  STDERR.puts "Try running `bundle install`."
  exit!     
end

