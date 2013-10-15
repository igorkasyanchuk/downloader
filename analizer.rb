class Analizer

  class << self

    def process
      links = []
      pages = RawPage.all
      pages.each_with_index do |page, index|
        doc = Nokogiri(page.content)
        hrefs = doc.css("#search_result a").collect{|e| e['href']}.uniq
        links += hrefs.select{|e| Allower.good?(e)}
        links.uniq!
        puts "processing raw page ##{index}. now we have #{links.size}"
      end
    end

  end

end
