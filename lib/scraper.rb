require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    # students = []
    # doc.css("div.roster-cards-container").each do |card|
    #   card.css(".student-card a").each do |student|
    #     s_profile_link = "#{student.attr('href')}"
    #     s_location = student.css('.student-location').text
    #     s_name = student.css('.student-name').text
    #     students << {name: s_name, location: s_location, profile_url: s_profile_link}
    #   end
    # end
    # students
  end
       binding.pry



  def self.scrape_profile_page(profile_url)
    
  end

end

# class = "." id = "#"
# div.roster-cards-container
# name = \h4.student-name"
# location = p.student-location"
# profile url = 


