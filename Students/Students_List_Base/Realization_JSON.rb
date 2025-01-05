require_relative 'Interface_Read_Write.rb'

class Realization_JSON < Interface_Read_Write

  def self.read(file_path)
    data = File.exist?(file_path) ? JSON.parse(File.read(file_path), symbolize_names: true) : []
    data.map { |student| Student.new(**student) }
  end

  def self.write(file_path, data)
    File.write(file_path, JSON.pretty_generate(data))
  end

end