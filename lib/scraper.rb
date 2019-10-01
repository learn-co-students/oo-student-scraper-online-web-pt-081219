require 'open-uri'
require 'Nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
    doc.css(".roster-cards-container").each do |roster|
    #binding.pry
   # Scraper.new.scrape_index_page
   # div class ="main-wrapper roster"
   # div class = ".roster-cards-container"
    end
  end
  #Scraper.new.scrape_index_page

  def self.scrape_profile_page(profile_url)
    
  end

end

