class Interface
  def ask_name
    puts "Введите ваше имя."
  end

  def get_answer
    gets.chomp
  end

  def output(message)
    puts message
  end

  def borderline
    puts "--------------------"
  end

  def greeting(name)
    puts "#{name}, добро пожаловать в игру Black Jack.\nНачинаем раздачу..."
  end

  def user_hand_message
    print "Ваша рука: "
  end

  def user_points_message
    print "Ваши очки: "
  end

  def dealer_hand_message
    print "Рука дилера: "
  end

  def dealer_points_message
    print "Очки дилера: "
  end

  def show_action_selection_menu
    puts "Выберите дальнейшее действие:\n" \
         "1 - Пропустить\n" \
         "2 - Добавить карту\n" \
         "3 - Открыть карты"
  end

  def player_skip_the_action_message
    puts "Вы пропустили ход."
  end

  def player_take_a_card_message
    puts "Вы взяли карту."
  end

  def wrong_input_message
    puts "Неверный ввод."
  end

  def dealer_take_a_card_message
    puts "Дилер взял карту."
  end

  def dealer_skip_the_action_message
    puts "Дилер пропустил ход."
  end

  def player_win_message
    puts "Поздравляем! Вы победили."
  end

  def dealer_win_message
    puts "Победил дилер."
  end

  def tie_message
    puts "Ничья."
  end

  def show_user_bank(bank)
    puts "Ваш банк составляет: #{bank}."
  end

  def show_dealer_bank(bank)
    puts "Банк дилера составляет: #{bank}."
  end

  def scores_overflow_message
    print "Число ваших очков превысило 21. "
  end

  def show_restart_game_menu
    puts "Сыграть еще раз?\n" \
         "1 - Да.\n" \
         "2 - Нет, завершить игру."
  end

  def end_game_message
    "Игра завершена."
  end

end
