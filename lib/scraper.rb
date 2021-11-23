require 'nokogiri'
require 'open-uri'
require 'pry'
require_relative './course.rb'

class Scraper
  
  def print_courses
    #Iterates over the @@all of courses and prints out each element
    self.make_courses
    Course.all.each do |course|
      if course.title && course.title != ""
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end
  def get_page
    #Returns all of the HTML from the page
    Nokogiri::HTML(open("http://learn-co-curriculum.github.io/site-for-scraping/courses"))
    
  end
  def get_courses
    #Uses a CSS selector to get all of the HTML elements that contain a course
    #The return value of this method should be a colection of Nokogiri XML elements
    #each of which describes a course offering
    self.get_page.css(".post")
  end
  def make_courses
    #Responsible for instantiating course objects. Gives each course the 
    #correct: title, schedule, and description
    self.get_courses.each do |post|
      course = Course.new
      course.title = post.css("h2").text
      course.schedule = post.css(".date").text
      course.description = post.css("p").text
      
    end
  end
  
  
end



Scraper.new.print_courses