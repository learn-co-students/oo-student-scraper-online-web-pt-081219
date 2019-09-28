require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    profiles = doc.css('.roster-cards-container .student-card')
    
    students = []
    
    #name = doc.css('.student-card a h4').text
    #location = doc.css('.student-card a p').text
    #profile_url = doc.css('.student-card a').first.attributes["href"].value
    
    profiles.each do |student|
      students.push({
        name: student.css('a h4').text,
        location: student.css('a p').text,
        profile_url: student.css("a").first.attributes["href"].value
      })
    end
    
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    return_hash = {}
    
    #Has Social?
    doc.css('.vitals-container .social-icon-container a').each do |social|

      icon_url = social.css("img")[0].attributes["src"].value
      social_type = nil
      
      case icon_url
        when "../assets/img/twitter-icon.png"
          social_type = :twitter
        when "../assets/img/linkedin-icon.png"
          social_type = :linkedin
        when "../assets/img/github-icon.png"
          social_type = :github
        when "../assets/img/rss-icon.png"
          social_type = :blog
      end
      
      return_hash[social_type] = social.attributes["href"].value
    end
    
    #Add Quote & Bio
    return_hash[:profile_quote] = doc.css('.vitals-text-container .profile-quote').text
    return_hash[:bio] = doc.css('.details-container .description-holder p').text
    
    return_hash
  end
  
end

