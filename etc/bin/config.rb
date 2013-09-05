require  'mongoid'
Mongoid.configure do |conf|
  conf.master = Mongo::Connection.new('localhost', 27017).db('ted')
end
