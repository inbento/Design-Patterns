require_relative 'Student'
require_relative 'Student_Short'
require_relative 'Student_Base'
require 'date'
require 'fox16'
require_relative 'Student_List_View.rb'

include Fox

application = FXApp.new
main_window = FXMainWindow.new(application, "Students App", nil, nil, DECOR_ALL, 0, 0, 800, 600)
Student_List_View.new(main_window)
application.create
main_window.show(PLACEMENT_SCREEN)
  
application.run