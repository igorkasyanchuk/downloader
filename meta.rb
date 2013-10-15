class Meta

  def cleanup
    print 'cleanup? (y/n): '.red
    if gets.downcase.chomp == ?y
      puts 'cleaning ....'
      #RawPage.destroy_all
      #Page.destroy_all
    else
      puts "skip cleaning ..."
    end
  end
  
  def initialize
    cleanup
    @root = Nokogiri(open('http://list.if.ua/metas'))
  end

  def links
    # take links and skip bad categories
    @root.css("ul.meta_categories li a").collect{|e| e['href']}.reject{|e| e =~ /\/23\//} 
  end

  def process
    total_links_count = links.size
    links.each_with_index do |link, index|
      follower = Follower.new(link)
      puts "Meta:process: #{link} #{index+1} of #{total_links_count} with 1/#{follower.last_page} pages".yellow
      follower.do_job
      puts ""
    end
  end

end