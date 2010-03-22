#! /usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'net/http'
require 'json'
require 'uri'
require 'pp'
require 'ostruct'

set :views => File.dirname(__FILE__) + '/views/'

get '/' do
  @builds = []
  [
    "192.168.53.214:8081", 
    "192.168.51.6:8080", 
    "192.168.53.73:8081"
  ].each do |host|
    host_results = JSON.parse(Net::HTTP.get(URI.parse("http://#{host}/api/json?depth=1")))
    @builds += host_results["jobs"]
  end
  erb :index
end
