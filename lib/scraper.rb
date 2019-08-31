require 'open-uri'
require 'nokogiri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
     array_of_students = Nokogiri::HTML(open("https://learn-co-curriculum.github.io/student-scraper-test-page/index.html")).css("div.student-card") 
  
     array = array_of_students.collect do |student|
          { :name => student.css("h4.student-name").text,
            :location => student.css("p.student-location").text , 
            :profile_url => student.css("a").attribute("href").value
          } 
      end
  end


  def self.scrape_profile_page(profile_url)
    more_info = Nokogiri::HTML(open("#{profile_url}"))
    
    social_medias = more_info.css("div.social-icon-container").css("a")
    
      profile_quote = more_info.css("div.profile-quote").text
    
    bio = more_info.css("div.description-holder").css("p").text
    
     hash = {:profile_quote => profile_quote,:bio => bio}
     
    social_medias.each do |el|  
      twitter =  el.attribute("href").value if el.attribute("href").value.include?("twitter")
         
      linkedin = el.attribute("href").value if el.attribute("href").value.include?("linkedin")
               
       github =  el.attribute("href").value if el.attribute("href").value.include?("github")
                    
       blog =  el.attribute("href").value if !el.attribute("href").value.include?("twitter") && !el.attribute("href").value.include?("linkedin") && !el.attribute("href").value.include?("github")
       hash[:twitter] = twitter if twitter 
       hash[:linkedin] = linkedin if linkedin 
       hash [:github] = github if github 
       hash[:blog] = blog if blog
    end
    
    hash
  end

end

