require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    html = open(index_url)
    index_page = Nokogiri::HTML(html)
    students = []

    index_page.css("div.student-card").each do |student|
      student_info = {
      :name => student.css("div.card-text-container h4.student-name").text, 
      :profile_url => student.css("a").attribute("href").text, 
      :location => student.css("div.card-text-container p.student-location").text 
      }
      students << student_info
    end 
    students 

  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    profile_page = Nokogiri::HTML(html)
    student = {}

    profile_page.css("div.social-icon-container a").collect {|media| media.attribute("href").text}.each do |link| 
        # social_media.each do |link|
          if link.include?("twitter")
            student[:twitter] = link
          elsif link.include?("linkedin")
            student[:linkedin] = link 
          elsif link.include?("github")
            student[:github] = link
          elsif link.include?(".com")
            student[:blog] = link   
          end 
          student[:profile_quote] = profile_page.css("div.vitals-text-container div.profile-quote").text  
          student[:bio] = profile_page.css("div.description-holder p").text 
          #binding.pry 
      end 
      student 

  end

end

