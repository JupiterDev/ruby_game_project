module Messages

  def greeting(name)
    puts "#{name}, добро пожаловать в игру Black Jack.\nНачинаем раздачу..."
  end

  def ask_name
    puts "Введите ваше имя."
  end

  def user_hand
    print "Ваша рука: "
  end

  def user_points
    print "Ваши очки: "
  end

  def dealer_hand
    print "Рука дилера: "
  end

  # def dealer_points
  #   print "Очки дилера: "
  # end

end

