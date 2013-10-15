require 'rubygems'
require 'active_record'
require 'nokogiri'
require "open-uri"
require 'pry'

require_relative 'colorize.rb'
require_relative 'allower.rb'
require_relative 'web_page.rb'
require_relative 'page.rb'
require_relative 'raw_page.rb'
require_relative 'follower.rb'
require_relative 'analizer.rb'
require_relative 'meta.rb'

ActiveRecord::Base.establish_connection(:adapter => 'sqlite3', :database => 'db.db')

#RawPage.destroy_all
#Page.destroy_all
