require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML( open(index_url))
    student_cards_array = []
    
    doc.css(".roster-cards-container").each do |card|
      doc.css(".student-card a").each_with_index do |student, i|
       student_cards_array[i] = {
        :name => student.css(".card-text-container h4.student-name").text,
        :location => student.css(".card-text-container p.student-location").text,
        :profile_url => student.attribute("href").value
        }
      end 
    end
    student_cards_array
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML( open(profile_url))
    
    student_profile = {}
    
    socials = doc.css(".social-icon-container").children.css("a").map{|a| a.attribute("href").value}
    
    socials.each do |link|
      if link.include?("twitter")
        student_profile[:twitter] = link 
      elsif link.include?("linkedin")
        student_profile[:linkedin] = link 
      elsif link.include?("github")
        student_profile[:github] = link 
      else 
        student_profile[:blog] = link 
      end 
    end 
    
    student_profile[:profile_quote] = doc.css(".profile-quote").text
    student_profile[:bio] = doc.css(".bio-content p").text
    
    student_profile

  end 

end