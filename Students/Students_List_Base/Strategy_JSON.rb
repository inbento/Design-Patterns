require_relative 'Interface_Read_Write.rb'

class Strategy_JSON < Interface_Read_Write

  def read(file_path)
    data = File.exist?(file_path) ? JSON.parse(File.read(file_path), symbolize_names: true) : []
    data.map { |student| Student.new(**student) }
  end

  def write(file_path, data)
    File.write(file_path, JSON.pretty_generate(data))
  end

end