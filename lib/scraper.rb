require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    index_page = Nokogiri::HTML(open(index_url))
    
    students = []
    
    index_page.css("div.student-card a").each{|student|
      hash = {}
      hash[:name] = student.css("h4.student-name").text
      hash[:location] = student.css("p.student-location").text
      hash[:profile_url] = student.attr("href")
      students << hash
      
     
    }
    
    #binding.pry
    students
    
  end

  def self.scrape_profile_page(profile_url)
    info = {}
    profile = Nokogiri::HTML(open(profile_url))
    
    profile.css("div.social-icon-container a").each do |icon|
      text = icon.css("img.social-icon").attr("src").value
      if text.include? "twitter"
        info[:twitter] = icon.attr("href")
      elsif text.include? "linkedin"
        info[:linkedin] = icon.attr("href")
      elsif text.include? "github"
        info[:github] = icon.attr("href")
      else
        info[:blog] = icon.attr("href")
      end
    end
    
    info[:profile_quote]= profile.css("div.profile-quote").text
    info[:bio]=profile.css("div.description-holder p").text
    #binding.pry
    info
  end

end

