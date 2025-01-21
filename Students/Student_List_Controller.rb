require_relative './Students_List_Base/Students_List_Base.rb'
require_relative './Data_List/Data_List_Student_Short.rb'
require_relative './Students_List_Base/Strategy_JSON.rb'

class Student_List_Controller

def initialize(view)
    self.view = view
    begin
        file_path = 'students.json'
        
        unless File.exist?(file_path)
            raise "Файл #{file_path} не найден."
        end
            
        self.student_list = Students_List_Base.new(file_path, Strategy_JSON.new)
        self.data_list = Data_List_Student_Short.new([])
        self.data_list.add_observer(self.view)
    rescue Exception => ex
        puts "Ошибка: #{ex.message}"
        raise
    end
end


def sort_table_by_column
    self.student_list.sort_by_full_name!
    self.data_list.notify(self.data)
end

def refresh_data
    self.data = self.student_list.get_k_n_student_short_list(self.view.current_page_label, self.view.class::ROWS_PER_PAGE)
    self.data_list.count = self.student_list.get_student_short_count
    self.data_list.notify(self.data)
end


def add

end


def delete(indexes)
     puts "Удаление записей с индексами #{indexes}"
end


def update(index)
    puts "Изменение записи с индексом: #{index}"
end


private

attr_accessor :view, :student_list, :data_list, :data

end