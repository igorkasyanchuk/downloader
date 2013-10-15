class Analizer

  class << self

    def process
      links = []
      pages = RawPage.all
      pages.each_with_index do |page, index|
        puts index
        doc = Nokogiri(page.content)
        hrefs = doc.css("a").collect{|e| e['href']}.uniq
        links += hrefs.select{|e| Allower.good?(e)}
        links.uniq!
        puts "#{index} now #{links.size}"
      end
      puts links
    end

  end

end
