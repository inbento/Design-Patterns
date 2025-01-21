require 'fox16'
require_relative './Data_List/Data_List_Student.rb'
require_relative 'Student.rb'

include Fox

class Student_List_View < FXVerticalFrame

  ROWS_PER_PAGE = 4
  
  def initialize(parent)
    super(parent, opts: LAYOUT_FILL)
    self.filters = {}
    setup_filtering_area
    setup_table_area
    setup_control_buttons_area
  end

  def setup_filtering_area
    filtering_area = FXVerticalFrame.new(self, opts: LAYOUT_FILL_X | LAYOUT_SIDE_TOP)
    FXLabel.new(filtering_area, "Фильтрация")
    name_text_field = nil
    FXHorizontalFrame.new(filtering_area, opts: LAYOUT_FILL_X) do |frame|
      FXLabel.new(frame, "Фамилия и инициалы:")
      FXTextField.new(frame, 20, opts: TEXTFIELD_NORMAL)
      name_text_field = FXTextField.new(frame, 20, opts: TEXTFIELD_NORMAL)
    end
    self.filters['name'] = { text_field: name_text_field }
    add_filtering_row(filtering_area, "Git:")
    add_filtering_row(filtering_area, "Email:")
    add_filtering_row(filtering_area, "Телефон:")
    add_filtering_row(filtering_area, "Telegram:")
    FXButton.new(filtering_area, "Сбросить", opts: BUTTON_NORMAL).connect(SEL_COMMAND) do
      reset_filters
    end

  end


  def add_filtering_row(parent, label)
    FXHorizontalFrame.new(parent, opts: LAYOUT_FILL_X) do |frame|
      FXLabel.new(frame, label)
      combo_box = FXComboBox.new(frame, 3, opts: COMBOBOX_STATIC | FRAME_SUNKEN)
      combo_box.numVisible = 3
      combo_box.appendItem("Не важно")
      combo_box.appendItem("Да")
      combo_box.appendItem("Нет")
      text_field = FXTextField.new(frame, 15, opts: TEXTFIELD_NORMAL)
      text_field.enabled = false
      self.filters[label] = { combo_box: combo_box, text_field: text_field }
      combo_box.connect(SEL_COMMAND) do
        text_field.enabled = (combo_box.currentItem == 1)
      end
    end
  end

  def setup_table_area
    table_area = FXVerticalFrame.new(self, opts: LAYOUT_FILL)
    self.table = FXTable.new(table_area, opts: LAYOUT_FILL | TABLE_READONLY | TABLE_COL_SIZABLE)
    self.table.setTableSize(ROWS_PER_PAGE, 6)
    self.table.rowHeaderMode = LAYOUT_FIX_WIDTH
    self.table.rowHeaderWidth = 30

    controls = FXHorizontalFrame.new(table_area, opts: LAYOUT_FILL_X)
    self.prev_button = FXButton.new(controls, "<<<", opts: BUTTON_NORMAL | LAYOUT_LEFT)
    self.current_page_label = FXLabel.new(controls, "Страница: 1/1", opts: LAYOUT_CENTER_X)
    self.next_button = FXButton.new(controls, ">>>", opts: BUTTON_NORMAL | LAYOUT_RIGHT)

    self.prev_button.connect(SEL_COMMAND) { switch_page(-1) }
    self.next_button.connect(SEL_COMMAND) { switch_page(1) }

    self.table.columnHeader.connect(SEL_COMMAND) do |_, _, column_index|
      sort_table_by_column(column_index)

  end

  def setup_control_buttons_area
      button_area = FXHorizontalFrame.new(self, opts: LAYOUT_FILL_X | PACK_UNIFORM_WIDTH)
      self.add_button = FXButton.new(button_area, "Добавить", opts: BUTTON_NORMAL)
      self.edit_button = FXButton.new(button_area, "Изменить", opts: BUTTON_NORMAL)
      self.delete_button = FXButton.new(button_area, "Удалить", opts: BUTTON_NORMAL)
      self.update_button = FXButton.new(button_area, "Обновить", opts: BUTTON_NORMAL)
      self.add_button.connect(SEL_COMMAND) { on_add }
      self.update_button.connect(SEL_COMMAND) { on_update }
      self.edit_button.connect(SEL_COMMAND) { on_edit }
      self.delete_button.connect(SEL_COMMAND) { on_delete }
      self.table.connect(SEL_SELECTED) { update_button_states }
      self.table.connect(SEL_DESELECTED) { update_button_states }
      update_button_states
    end
    populate_table

  end

    private
  
  attr_accessor :table, :data, :total_pages, :current_page, :current_page_label, :prev_button, :next_button, :sort_order, :add_button, :update_button, :edit_button, :delete_button,
  :filters

  def populate_table
    data_list = Data_List_Student.new([
      Student.new(last_name: "Миков", first_name: "Никита", middle_name: "Сергеевич", git: "https://github.com/inbento", id: 1, telegram: "@Nekita", birth_date: "12.12.2012", email: "nekita@gmail.com", phone: "+75828924547"),
      Student.new(last_name: "Гойда", first_name: "Гойда", middle_name: "Гойда", git: "https://github.com/goida", id: 2, telegram: "@goida", birth_date: "10.11.1999", email: "goida@gmail.com", phone: "+75809921443"),
      Student.new(last_name: "Вертолетов", first_name: "Вертолет", middle_name: "Вертолетович", git: "https://github.com/helecopter", id: 3, telegram: "@helecopter", birth_date: "19.08.2021", email: "helecopter@gmail.com", phone: "+75021654701"),
    ])

    self.data = data_list.get_data
    self.total_pages = ((self.data.row_count - 1).to_f / ROWS_PER_PAGE).ceil
    self.current_page = 1
    update_table
  end

  def update_table(sorted_data = nil)
    return if self.data.nil? || self.data.row_count <= 1
    (0...self.data.column_count).each do |col_index|
      self.table.setColumnText(col_index, self.data.get(0, col_index).to_s)
    end
    clear_table
    data_to_display = sorted_data || get_page_data(self.current_page)
    data_to_display.each_with_index do |row, row_index|
      row.each_with_index do |cell, col_index|
        self.table.setItemText(row_index, col_index, cell.to_s)
      end
    end
    self.current_page_label.text = "Страница: #{self.current_page}/#{self.total_pages}"
  end

  def clear_table
    (0...ROWS_PER_PAGE).each do |row_index|
      (0...self.data.column_count).each do |col_index|
        self.table.setItemText(row_index, col_index, "")
      end
    end
  end

  def get_page_data(page_number)
    start_index = (page_number - 1) * ROWS_PER_PAGE + 1
    end_index = start_index + ROWS_PER_PAGE - 1
    data_page = []
    (start_index..end_index).each do |row_index|
      break if row_index >= self.data.row_count
      row = []
      (0...self.data.column_count).each do |col_index|
        row << self.data.get(row_index, col_index)
      end
      data_page << row
    end
    data_page
  end

  def switch_page(direction)
    new_page = self.current_page + direction
    return if new_page < 1 || new_page > self.total_pages
    
    self.current_page = new_page
    update_table
  end

  def sort_table_by_column(column_index)
    return if self.data.nil? || self.data.row_count <= 1
  
    headers = (0...self.data.column_count).map { |col_index| self.data.get(0, col_index) }
    rows = (1...self.data.row_count).map do |row_index|
      (0...self.data.column_count).map { |col_index| self.data.get(row_index, col_index) }
    end
  
    self.sort_order ||= {}
    self.sort_order[column_index] = !self.sort_order.fetch(column_index, false)
    sorted_rows = rows.sort_by do |row|
      value = row[column_index]
      if value.nil?
        ''
      else
        value.to_s
      end
    end

    sorted_rows.reverse! unless self.sort_order[column_index]
    all_rows = [headers] + sorted_rows
    self.data = Data_Table.new(all_rows)
    update_table
  end

  def get_selected_rows
    selected_rows = []
    (0...self.table.numRows).each do |row|
      selected_rows << row if self.table.rowSelected?(row)
    end
    selected_rows
  end
  
  def update_button_states
    selected_rows = get_selected_rows
  
    self.add_button.enabled = true
    self.update_button.enabled = true
  
    case selected_rows.size
    when 0
      self.edit_button.enabled = false
      self.delete_button.enabled = false
    when 1
      self.edit_button.enabled = true
      self.delete_button.enabled = true
    else
      self.edit_button.enabled = false
      self.delete_button.enabled = true
    end
  end

  def on_add

  end
  
  def on_update

  end
  
  def on_edit

  end
  
  def on_delete

  end

  def reset_filters
    self.filters.each_value do |field|
      field[:combo].setCurrentItem(0) if !field[:combo].nil?
      field[:text_field].text = ""
    end
    populate_table
  end
  
end