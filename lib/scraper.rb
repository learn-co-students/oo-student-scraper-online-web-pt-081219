require 'nokogiri'
require 'open-uri'
require 'pry'

class Scraper
  
  def self.scrape_index_page(index_url)
    
    html = open(index_url)

    doc = Nokogiri::HTML(html)
    n = doc.css(".student-name")
    sl = doc.css(".student-location")
    doc.css("div.student-card a")
    

        
  
  
  end
end
