#!/usr/bin/env ruby
require "open-uri"
require "json"
require "nokogiri"
require 'mongoid'

Mongoid.configure do |conf|
  conf.master = Mongo::Connection.new('localhost', 27017).db('ted')
end
class Mongo::TED
  include Mongoid::Document
  self.collection_name = 'talk'
  field :id,         :type   => Float
  field :url,        :type   => String
  field :text,       :type   => String
  field :created_at, :type   => DateTime, :default => lambda{Time.now}
  index :id,         :unique => true
end

if $0 == __FILE__
  # write this
  ted_url = ARGV[0]
  unless ted_url =~ /http/
    raise "u need url"
  end
  doc = Nokogiri::HTML(open(ted_url))
  ted_id = doc.xpath("//div[@id='share_and_save']").first.attribute("data-id").text.to_i

  if ted_id
        Mongo::TED.create(
                          id:  ted_id,
                          url: ted_url,
                          text:'', # get subtitles
                          )
  end
  # open("http://www.ted.com/talks/subtitles/id/#{ted_id}/lang/en") do |f|
  #   json = JSON.parse(f.read)
  #   json['captions'].each do |j|
  #     puts j['content']
  #   end
  # end
end
