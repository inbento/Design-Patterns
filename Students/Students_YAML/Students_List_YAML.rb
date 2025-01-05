require 'yaml'
require_relative '../Student.rb'
require_relative '../Student_Short.rb'
require_relative '../Data_List/Data_List_Student_Short.rb'

class Students_List_YAML

    def initialize(file_path)
        self.file_path = file_path
        self.students = read_from_file
    end

    def read_from_file
        return [] unless File.exist?(self.file_path)
        data = YAML.safe_load(File.read(self.file_path), permitted_classes: [Date, Symbol])
        data.map { |student| Student.new(**student) }
    end

    def write_to_file
        data = self.students.map { |student| student.to_hash }
        File.write(self.file_path, data.to_yaml)
    end

    def get_student_by_id(id)
        self.students.find { |student| student.id == id }
    end

    def get_k_n_student_short_list(k, n, data_list = nil)
        start = (k - 1) * n
        students_short = self.students[start, n].map { |student| Student_Short.by_student(student) }
        data_list ||= Data_List_Student_Short.new(students_short)
        data_list
    end


    def sort_by_full_name!
        self.students.sort_by! { |student| student.surname_with_initials }
    end


    def add_student(student)
        max_id = self.students.map(&:id).max || 0
        student.id = max_id + 1
        self.students << student
    end


    def update_student(id, updated_student)
        index = self.students.find_index { |student| student.id == id }
        raise IndexError, 'Студент с таким id не найден' unless index
        updated_student.id = id
        self.students[index] = updated_student
    end


    def delete_student(id)
        self.students.reject! { |student| student.id == id }
    end

    def get_student_short_count
        self.students.size
    end

    private
    attr_accessor :file_path, :students

end