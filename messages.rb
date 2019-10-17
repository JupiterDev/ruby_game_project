module Messages

  def greeting(name)
    puts "#{name}, добро пожаловать в игру Black Jack.\nНачинаем раздачу..."
  end

  def ask_name
    puts "Введите ваше имя."
  end

  def user_hand
    puts "Ваша рука:"
  end

  def dealer_hand
    puts "Рука дилера:"
  end

end

