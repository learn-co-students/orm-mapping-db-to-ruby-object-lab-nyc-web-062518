require 'pry'

class Student
  attr_accessor :id, :name, :grade

  def self.new_from_db(row)
    student = Student.new
    student.id = row[0]
    student.name = row[1]
    student.grade = row[2]
    student
  end

  def self.all

    table = run_sql('SELECT * from students')
    table
    # retrieve all the rows from the "Students" database
    # remember each row should be a new instance of the Student class
  end

  def self.find_by_name(name)
    hash = run_sql('SELECT * FROM students WHERE name = ?', name)
    student = Student.new_from_db(hash)
    # find the student in the database given a name
    # return a new instance of the Student class
    student
  end

  def save
    sql = <<-SQL
      INSERT INTO students (name, grade)
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end

  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end

  def run_sql(string, *args)
   DB[:conn].execute(string, *args)
 end

 def self.run_sql(string, *args)
   DB[:conn].execute(string, *args)
 end


end

yosi = Student.new_from_db(id: 1, name: "joe", grade: 9);
yosi.find_by_name('Joe')
binding.pry
