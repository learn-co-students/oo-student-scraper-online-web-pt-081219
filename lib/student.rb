class Student

  attr_accessor :name, :location, :twitter, :linkedin, :github, :blog, :profile_quote, :bio, :profile_url 

  @@all = []

  def initialize(student_hash)
 
    @name = student_hash[:name] 
    @location = student_hash[:location]
    
    @@all << self
  end

  def self.create_from_collection(students_array)
     students_array.each do |student_hash|
       student_hash.each do |key,val|
         student = Student.new(student_hash)
         student.send("#{key}=",val )
        
       end
     end
  end

  def add_student_attributes(attributes_hash)
    
   attributes_hash.each{|key,val| self.send("#{key}=",val)}
  end

  def self.all
    @@all
  end
end

