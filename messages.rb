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

  def dealer_points
    print "Очки дилера: "
  end

  def action_selection
    puts "Выберите дальнейшее действие:\n" \
         "1 - Пропустить\n" \
         "2 - Добавить карту\n" \
         "3 - Открыть карты"
  end

  def player_take_a_card
    puts "Вы взяли карту."
  end

  def dealer_take_a_card
    puts "Дилер взял карту."
  end

  def dealer_skiped_the_action
    puts "Дилер пропустил ход."
  end

  def wrong_input
    puts "Неверный ввод."
  end

  def player_win
    puts "Поздравляем! Вы победили."
  end

  def dealer_win
    puts "Победил дилер."
  end

  def tie
    puts "Ничья."
  end

  def user_bank(bank)
    puts "Ваш банк составляет: #{bank}."
  end

  def dealer_bank(bank)
    puts "Банк дилера составляет: #{bank}."
  end

  def border
    puts "--------------------"
  end

  def restart_game
    puts "Сыграть еще раз?\n" \
         "1 - Да.\n" \
         "2 - Нет, завершить игру."
  end

  def end_game
    "Игра завершена."
  end

end

