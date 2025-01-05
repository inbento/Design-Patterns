require_relative '../Student.rb'
require_relative '../Student_Short.rb'
require_relative '../Data_List/Data_List_Student_Short.rb'
require 'json'
require 'yaml'

class Students_List_Base

    def initialize(file_path, strategy)
        @file_path = file_path
        @strategy = strategy
        @students = read(@file_path)
    end
  
    def read(file_path=@file_path)
        @strategy.read(file_path)
    end
  
    def write(file_path=@file_path, data=@students.map(&:to_hash))
        @strategy.write(file_path, data)
    end
  
    def get_student_by_id(id)
      @students.find { |student| student.id == id }
    end
  
    def get_k_n_student_short_list(k, n, data_list = nil)
        start = (k - 1) * n
        students_short = @students[start, n].map { |student| Student_Short.by_student(student) }
        data_list ||= Data_List_Student_Short.new(students_short)
        data_list
    end

    def sort_by_full_name!
        @students.sort_by! { |student| student.surname_with_initials }
    end
  
    def add_student(student)
        if @students.any? { |s| s.git == student.git || s.contact == student.contact }
            raise NameError, 'Студент с такимими данными уже существует'
        end

        max_id = @students.map(&:id).max || 0
        student.id = max_id + 1
        @students << student
    end
  
    def update_student(id, updated_student)
        index = @students.find_index { |student| student.id == id }
        raise IndexError, 'Студент с таким id не найден' unless index
        if @students.any? { |s| s.git == updated_student.git || s.contact == updated_student.contact }
            raise NameError, 'Студент с такимими данными уже существует'
        end
        updated_student.id = id
        @students[index] = updated_student
    end
  
    def delete_student(id)
      @students.reject! { |student| student.id == id }
      write(@file_path)
    end

    def get_student_short_count
        @students.size
    end

    private
    attr_accessor :file_path, :students

  end