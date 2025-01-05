require_relative '../Student.rb'
require_relative '../Student_Short.rb'
require_relative '../Data_List/Data_List_Student_Short.rb'
require_relative 'Data_Base_CLient'


class Students_List_DB

  def get_student_by_id(id)
    query = 'SELECT * FROM students WHERE id = ?'
    student_data = Data_Base_CLient.instance.query(query, [id]).first
    return nil unless student_data
    Student.new(student_data.transform_keys(&:to_sym))
  end

  def get_k_n_student_short_list(k, n)
    start = (k - 1) * n
    query = 'SELECT * FROM students LIMIT ? OFFSET ?'
    students_data = Data_Base_CLient.instance.query(query, [n, start])
    students_short = students_data.map { |student| Student_Short.bydb(student.transform_keys(&:to_sym)) }
    Data_List_Student_Short.new(students_short)
  end

  def add_student(student)
    query = <<~SQL
      INSERT INTO students (last_name, first_name, middle_name, birth_date, phone, git, telegram, email)
      VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    SQL
    id = Data_Base_CLient.instance.query(query, [
      student.last_name, student.first_name, student.middle_name,
      student.birth_date, student.phone, student.git, student.telegram, student.email
    ])
    student.id = Data_Base_CLient.instance.query('SELECT last_insert_rowid()').first[:last_insert_rowid]
  end

  def update_student_by_id(id, student)
    query = <<~SQL
      UPDATE students
      SET last_name = ?, first_name = ?, middle_name = ?, birth_date = ?,
          phone = ?, git = ?, telegram = ?, email = ?
      WHERE id = ?
    SQL
    Data_Base_CLient.instance.query(query, [
      student.last_name, student.first_name, student.middle_name,
      student.birth_date, student.phone, student.git, student.telegram, student.email, id
    ])
  end

  def delete_student_by_id(id)
    query = 'DELETE FROM students WHERE id = ?'
    Data_Base_CLient.instance.query(query, [id])
  end

  def get_student_count
    query = 'SELECT COUNT(*) AS count FROM students'
    Data_Base_CLient.instance.query(query).first['count']
  end

end