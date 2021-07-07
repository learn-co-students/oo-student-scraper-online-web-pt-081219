class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
    student_hash.map do |a, v|
      self.send("#{a}=", v)
    end 
    @@all.push(self)
    
  end

  def self.create_from_collection(students_array)
     students_array.map do |student_hash|
       Student.new(student_hash)
     end 
   end

  def add_student_attributes(attributes_hash)
     attributes_hash.map do |a, v|
       self.send("#{a}=", v)
  end
end 

  def self.all
    return @@all
  end
end

