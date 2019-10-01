require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper

  def self.scrape_index_page(index_url)
    url = index_url
    html = open(url)
    doc = Nokogiri::HTML(html)
  
    # puts doc.css("div#roster-body_wrapper")
     binding.pry
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

# class = "." id = "#"
# name = \h4.student-name"
# location = p.student-location"
# profile url = 


