require 'uri'
require 'net/http'

class Follower

  def initialize(filter_page_url)
    @filter_page_url = filter_page_url
    content, status = open_page(page(first_page))
    @doc = Nokogiri(content)
  end

  def open_page(url)
    print "Follower::open_page #{url}"
    url = "http://list.if.ua#{url}"
    uri = URI(url)
    http = Net::HTTP.new(uri.host, 80)
    request = Net::HTTP::Get.new(uri.request_uri)
    # copy cookies from browser
    request['Cookie'] = "b=b; __atuvc=1%7C42; PHPSESSID=0tov0e12s38olhmr2eeeoiun25; __utma=28427169.1038154219.1381838442.1381838442.1381838442.1; __utmb=28427169.10.10.1381838442; __utmc=28427169; __utmz=28427169.1381838442.1.1.utmcsr=(direct)|utmccn=(direct)|utmcmd=(none)"
    response = http.request(request)  
    status = response.code.to_i
    color = case status 
      when 500 then :red
      when 200 then :green
      when 404 then :yellow
    end
    puts "...".send(color)
    puts ''
    [response.body, status]
  end

  def first_page
    1
  end

  def session_cookies
    @cookies
  end

  def last_page
    @doc.css(".pagination a").last['href'] =~ /page=(\d+)/ rescue 1
    [$1.to_i, 1].max
  end

  def page(number)
    "#{@filter_page_url}?page=%{number}" % {number: number}
  end

  def do_job
    (first_page..last_page).each do |number|
      url = page(number)
      content, status, cookies = open_page(url)
      RawPage.create url: url, content: content, created_on: Date.today, status: status
      puts "Follower:do_job: #{url}"
      sleep(2)
    end
  end

end
