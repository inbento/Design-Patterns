class Data_List

    def initialize(elements)

      unless elements.is_a?(Array)
        raise ArgumentError, 'Данные должны быть массивом'
      end

      @elements = elements.dup
      @selected_id = []
    end
  
    def select(number)
      validate_index(number)
      id = @elements[number].id 
      @selected_id << id unless @selected_id.include?(id)
    end
  
    def get_selected
      @selected_id.dup
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
  
    private

    def validate_index(index)
      unless index.between?(0, @elements.size - 1)
        false
      end
      true
    end

  end