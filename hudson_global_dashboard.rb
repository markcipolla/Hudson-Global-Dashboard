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
  # All the internal IP addresses of your Hudson machines.
  @individual_hudsons = [
    "192.168.53.214:8081", 
    "192.168.51.6:8080", 
    "192.168.53.187:8081",
    "192.168.52.30:8888"
  ]
  
  @builds = []
  @individual_hudsons.each do |host|
    host_results = JSON.parse(Net::HTTP.get(URI.parse("http://#{host}/api/json?depth=1")))
    @builds += host_results["jobs"]
  end
  erb :index
end
