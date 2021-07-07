require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    web_page = Nokogiri::HTML(open(index_url))
    
    students = []
    
    web_page.css("div.roster-cards-container").map do |card|
      card.css(".student-card a").map do |student| 
        student_profile_url = "#{student.attr('href')}"
        student_location = student.css('.student-location').text 
        student_name = student.css('.student-name').text 
        
        students.push({profile_url: student_profile_url, location: student_location, name: student_name})
      end 
    end 
    
    return students 
        
  end

   def self.scrape_profile_page(profile_url)
    profile_page = Nokogiri::HTML(open(profile_url))
    
    students = {}
      
    media_sites = profile_page.css(".social-icon-container").children.css("a").map { |n| n.attribute('href').value}
    media_sites.map do |site|
      if site.include?("twitter")
        students[:twitter] = site
      elsif site.include?("linkedin")
        students[:linkedin] = site
      elsif site.include?("github")
        students[:github] = site
      else
        students[:blog] = site
      end
    end
    
    students[:profile_quote] = profile_page.css(".profile-quote").text if profile_page.css(".profile-quote")
    students[:bio] = profile_page.css("div.bio-content.content-holder div.description-holder p").text if profile_page.css("div.bio-content.content-holder div.description-holder p")

    return students
  end

end