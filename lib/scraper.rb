require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    array = []
    page = Nokogiri::HTML(open(index_url))
    page.css(".student-card").collect do |student|
      student_hash = {
        :name => student.css("h4.student-name").text,
        :location => student.css("p.student-location").text,
        :profile_url => student.css("a").attribute("href").value
      }
      array << student_hash
    end
    array
  end

 def self.scrape_profile_page(profile_url)
      page = Nokogiri::HTML(open(profile_url))
      hash = {}

      website = page.css(".social-icon-container a").collect{|site| site.attribute("href").value}
      website.each do |link|
        if link.include?("twitter")
          hash[:twitter] = link
        elsif link.include?("linkedin")
          hash[:linkedin] = link
        elsif link.include?("github")
          hash[:github] = link
        elsif link.include?(".com")
          hash[:blog] = link
        end
      end
      hash[:profile_quote] = page.css(".profile-quote").text
      hash[:bio] = page.css("div.description-holder p").text
      hash
  end
  
end

