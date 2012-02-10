#!/usr/bin/env ruby

require 'thor'

class Sample < Thor
  desc 'hello', 'Hello, World!'
  def hello
    puts 'Hello, World!'
  end
end

if $0 == __FILE__
  # write this
  Sample.start
end
