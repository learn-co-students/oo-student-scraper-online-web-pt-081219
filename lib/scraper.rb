require 'open-uri'
require 'pry'
require 'nokogiri'

class Scraper
  

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        s_profile_link = "#{student.attr("href")}"
        s_location = student.css('.student-location').text
        s_name = student.css('.student-name').text
        students << {name: s_name, location: s_location, profile_url: s_profile_link}
        
        # class = "." id = "#"
        # div.roster-cards-container
        # name = \h4.student-name"
        # location = p.student-location"
        # profile url = 

      end
    end
    students
        # binding.pry
  end



  def self.scrape_profile_page(profile_url)
    student_hash = {}
    profile = Nokogiri::HTML(open(profile_url))
    links = profile.css(".social-icon-container").children.css("a").map { |child| child.attribute('href').value }
        links.each do |link|
        if link.include?("linkedin")
        student_hash[:linkedin] = link
      elsif link.include?("github")
        student_hash[:github] = link
      elsif link.include?("twitter")
        student_hash[:twitter] = link
      else
        student_hash[:blog] = link
      end
    end
    
      student_hash[:profile_quote] = profile.css(".profile-quote").text if profile.css(".profile-quote")
      student_hash[:bio] = profile.css("div.bio-content.content-holder div.description-holder p").text if 
      profile.css("div.bio-content.content-holder div.description-holder p")

    student_hash
  end
 binding.pry

    
    
    # student[:twitter] = profile_page.css(".social-icon-container").children.css("a")[0].attribute("href").value
    # 
    # student[:linkedin] = profile_page.css(".social-icon-container").children.css("a")[1].attribute("href").value 
    # student[:github] = profile_page.css(".social-icon-container").children.css("a")[2].attribute("href").value 
    # student[:blog] = profile_page.css(".social-icon-container").children.css("a")[3].attribute("href").value 

end



