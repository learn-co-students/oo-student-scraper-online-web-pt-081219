require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    students = []
    doc.css("div.roster-cards-container").each do |card|
      card.css(".student-card a").each do |student|
        student_profile = "#{student.attr('href')}"
        student_location = student.css('.student-location').text
        student_name = student.css('.student-name').text
        students << {profile_url: student_profile, location: student_location, name: student_name}
      end
    end
    students
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    student = {}
    all_social = doc.search(".social-icon-container").children.css("a").map {|social| social.attribute('href').value}
    all_social.each do |social|
        if social.include?("twitter")
          student[:twitter] = social
        elsif social.include?("linkedin")
          student[:linkedin] = social
        elsif social.include?("github")
          student[:github] = social
        else
          student[:blog] = social
        end
      end
    student[:profile_quote] = doc.css(".profile-quote").text if doc.css(".profile-quote")
    student[:bio] = doc.css("div.bio-content.content-holder div.description-holder p").text if doc.css("div.bio-content.content-holder div.description-holder p")
    student
    end

end

