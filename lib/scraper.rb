require 'open-uri'
require 'Nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html"))
    student_roster = []
    doc.css("div.roster-cards-container").collect do |roster|
      roster.css(".student-card a").each do |student|
        name = student.css(".student-name").text
        location = student.css(".student-location").text
        profile_url = student.attribute("href").value
        student_roster << {name: name, location: location, profile_url: profile_url }

    #binding.pry
      end
    end
    student_roster
  end
  

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = Hash.new
    social_icons = doc.css("div.social-icon-container a").collect {|x| x.attribute("href").value}
    social_icons.each do |social_icon|
     if social_icon.include?("linkedin")
       student[:linkedin] = social_icon
     elsif social_icon.include?("github")
       student[:github] = social_icon
     elsif social_icon.include?("twitter")
       student[:twitter] = social_icon
     else
       student[:blog] = social_icon
     end
   end
     student[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text
     student[:profile_quote] = doc.css(".profile-quote").text
   student
  end


   





end