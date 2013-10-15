require_relative 'init.rb'

# root = WebPage.new("http://list.if.ua/filter_by/11/115-kafe-bari")

# puts "Page: #{root.url}".pur

# root.links.each do |link|
#   if Allower.good?(link)
#     puts "#{link} GOOD".green
#   else
#     puts "#{link} BAD".red
#   end
# end

#binding.pry

#Follower.new.do_job

Analizer.process
