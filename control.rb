require_relative 'messages'

class Control
  include Messages   # вынес все puts в отдельный модуль

  def start
    greeting
    ask_name
  end
end
