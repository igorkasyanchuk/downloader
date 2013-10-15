require 'uri'
require 'net/http'

class Follower

  def initialize
    url = page(first_page)
    response = Net::HTTP.get_response(URI.parse(url).host, URI.parse(url).path)
    @doc = Nokogiri(response.body)
  end

  def open_page(url)
    response = Net::HTTP.get_response(URI.parse(url).host, URI.parse(url).path)
    [response.body, response.code]
  end

  def first_page
    1
  end

  def last_page
    @doc.css(".pagination a").last['href'] =~ /(\d+)/
    $1.to_i
  end

  def page(number)
    "http://list.if.ua/filter_by/0/0?page=%{number}" % {number: number}
  end

  def do_job
    (first_page..last_page).each do |number|
      url = page(number)
      content, status = open_page(url)
      RawPage.create url: url, content: content, created_on: Date.today, status: status
      puts "processed: #{url}"
      sleep(2)
    end
  end

end
