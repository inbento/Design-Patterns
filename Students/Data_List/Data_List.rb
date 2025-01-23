require_relative 'Data_table.rb'

class Data_List

  attr_accessor :elements, :selected_id, :count, :observers, :start

    def initialize(elements)

      unless elements.is_a?(Array)
        raise ArgumentError, 'Данные должны быть массивом'
      end

      self.elements = elements.dup
      self.selected_id = []
      self.observers = []
      self.start = 0
    end
  
    def select(number)
      validate_index(number)
      id = self.elements[number].id 
      self.selected_id << id unless self.selected_id.include?(id)
    end
  
    def get_selected
      self.selected_id.dup
    end

    def get_names
      raise NotImplementedError, 'Метод get_names должен быть реализован в наследниках'
    end
  
   def get_data
      datatable=[]
      datatable << self.get_names
      datatable.concat(self.get_info)
      Data_Table.new(datatable)
    end
    
    def get_info
      raise NotImplementedError, 'Метод get_info должен быть реализован в наследниках'
    end

    def add_observer(observer)
      self.observers << observer
    end


    def notify(data)
      self.observers.each do |observer|
        observer.set_table_params(data.get_names, self.count)
        observer.set_table_data(data.get_data)
      end
    end
  
    private

    def validate_index(index)
      unless index.between?(0, @elements.size - 1)
        false
      end
      true
    end

  end