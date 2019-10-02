class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.each {|k, v| self.send(("#{k}="), v)} #takes in an argument of a hash and sets that new student's attributes using the key/value pairs of that hash.
    @@all << self
  end

  def self.create_from_collection(students_array)
    students_array.each do |students_hash|
      self.new(students_hash)
  end
end

  def add_student_attributes(attributes_hash)
    attributes_hash.each do |k, v|
      self.send(("#{k}="), v)
  end
  self
end

  def self.all
    @@all
  end
end

