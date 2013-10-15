class WebPage
  attr_reader :url

  def initialize(url)
    @url = url
    @doc = Nokogiri(open(url))
  end

  def links
    @doc.css("a").collect{|e| e['href']}
  end

end
