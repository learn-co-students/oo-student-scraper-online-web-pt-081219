require 'open-uri'
require 'pry-byebug'
require 'nokogiri'

class Scraper
  def self.scrape_index_page(index_url)
    doc = Nokogiri::HTML(open(index_url))
    doc.css(".student-card").map do |student|
      name = student.at_css("h4").text
      location = student.at_css(".student-location").text
      profile_url = student.at_css("a").attr("href")
      { name: name, location: location, profile_url: profile_url }
    end
  end

  def self.scrape_profile_page(profile_url)
    doc = Nokogiri::HTML(open(profile_url))
    scraped_student = {}

    person = doc.at_css(".vitals-container")
    vitals = person.at_css(".vitals-text-container")
    quote = vitals.at_css(".profile-quote").text
    details = doc.at_css(".details-container")
    bio = details.at_css(".description-holder").text.strip

    twitter_link = social_href(doc, "twitter")
    linkedin_link = social_href(doc, "linkedin")
    github_link = social_href(doc, "github")
    blog_link = social_href(doc, "rss")

    scraped_student[:twitter] = twitter_link unless twitter_link.nil?
    scraped_student[:linkedin] = linkedin_link unless linkedin_link.nil?
    scraped_student[:github] = github_link unless github_link.nil?
    scraped_student[:blog] = blog_link unless blog_link.nil?
    scraped_student[:profile_quote] = quote unless quote.nil?
    scraped_student[:bio] = bio unless bio.nil?
    scraped_student
  end

  private
  def self.social_href(doc, icon)
    social_icon = doc.at_css(".social-icon[src='../assets/img/#{icon}-icon.png']")
    social_icon&.parent&.attr("href")
  end
end
