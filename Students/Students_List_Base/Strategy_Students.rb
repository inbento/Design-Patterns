class Strategy_Students

    def read(file_path)
      raise NotImplementedError, 'Метод должен быть определён в подклассе'
    end

    def write(file_path, data)
      raise NotImplementedError, 'Метод должен быть определён в подклассе'
    end

  end