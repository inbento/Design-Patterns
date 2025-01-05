require_relative 'Interface_Read_Write.rb'

class Realization_YAML < Interface_Read_Write

  def self.read(file_path)
    data = File.exist?(file_path) ? YAML.safe_load(File.read(file_path), permitted_classes: [Date, Symbol]) : []
    data.map { |student| Student.new(**student) }
  end

  def self.write(file_path, data)
    File.write(file_path, data.to_yaml)
  end

end