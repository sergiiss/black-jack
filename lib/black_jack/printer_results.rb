module BlackJack
  class PrinterResults
    attr_reader :machine_points, :player_points, :golden_point_machine, :golden_point_player

    def initialize(machine_points, player_points, golden_point_machine, golden_point_player)
      @machine_points         = machine_points
      @player_points          = player_points
      @golden_point_machine   = golden_point_machine
      @golden_point_player    = golden_point_player
    end

    def result_games
      case
      when golden_point_player_win
        puts "У тебя 'золотое очко'. Ты победитель!"
      when golden_point_machine_win
        puts "У меня 'золотое очко'. Сегодня победа за мной!"
      when black_jack_player
        puts 'Ты победитель!'
      when black_jack_machine
        puts 'Сегодня победа за мной!'
      when draw
        puts 'У нас с тобой ничья!'
      when bust_machine
        puts 'Ты победитель!'
      when bust_player
        puts 'Сегодня победа за мной!'
      when both_gleaning
        if player_points > machine_points
          puts 'Ты победитель!'
        elsif player_points == machine_points
          puts 'У нас с тобой ничья!'
        elsif player_points < machine_points
          puts 'Сегодня победа за мной!'
        end
      end
    end

    def golden_point_machine_win
      machine_points == 22 && golden_point_machine == 2
    end

    def golden_point_player_win
      player_points == 22 && golden_point_player == 2
    end

    def black_jack_player
      player_points == 21 && machine_points != 21
    end

    def black_jack_machine
      player_points != 21 && machine_points == 21
    end

    def bust_player
      player_points > 21 && machine_points < 21
    end

    def bust_machine
      player_points < 21 && machine_points > 21
    end

    def draw
      player_points == 21 && machine_points == 21
    end

    def both_gleaning
      player_points < 21 && machine_points < 21
    end
  end
end
