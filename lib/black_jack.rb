require_relative 'printer_results'
require_relative 'ask'

class BlackJack
  include Ask
  
  attr_reader :card_player, :card_machine, :player_points, :machine_points, :golden_point_player, :golden_point_machine, 
                :pack_parity, :continue_game, :distribution

  def initialize
    @player_points = 0
    @machine_points = 0
    @golden_point_player = 0
    @golden_point_machine = 0
    @continue_game = true
    @distribution = "Yes"
    
    @pack_parity = {
      "6S"  => 6, "6H"  => 6, "6C"  => 6,  "6D"  => 6,  "7S" => 7,  "7H" => 7, "7C" => 7, "7D" => 7,
      "8S"  => 8, "8H"  => 8, "8C"  => 8,  "8D"  => 8,  "9S" => 9,  "9H" => 9, "9C" => 9, "9D" => 9,
      "10S" => 10,"10H" => 10,"10C" => 10, "10D" => 10, "JS" => 2,  "JH" => 2, "JC" => 2,
      "JD"  => 2, "QS"  => 3, "QH"  => 3,  "QC"  => 3,  "QD" => 3,  "KS" => 4, "KH" => 4,
      "KC"  => 4, "KD"  => 4, "AS"  => 11, "AH"  => 11, "AC" => 11, "AD" => 11
    }
   
    @card_suit = {
      "S" => 6, "H" => 3, "C" => 5, "D" => 4
    }
  end

  def game
    welcome_player  
    perform_first_hand_of_cards
    perform_the_remaining_cards_are_dealt
    inform_the_result_of_the_game
  end

  private  
              
  def perform_first_hand_of_cards
    distribution_card_player(get_a_random_number)
    distribution_card_machine(get_a_random_number)
  end

  def perform_the_remaining_cards_are_dealt
    while check_the_condition_of_the_continuation_of_the_game
      gameplay
    end   
    
    report_on_completion_of_the_game(machine_points, player_points)
  end
  
  def check_the_condition_of_the_continuation_of_the_game
    continue_game == true && player_points < 21 && machine_points < 21 || machine_points < 19 && player_points < 21 && machine_points <= player_points
  end
  
  def gameplay
    if continue_game == true && player_points < 21
      get_the_answer_player
      to_continue_a_game?
    end
    
    distribution_card_machine(get_a_random_number) if continue_game == true || machine_points <= player_points
  end  
  
  def to_continue_a_game?
    if distribution == "yes" || distribution == "Yes"
      distribution_card_player(get_a_random_number)
    else
      @continue_game = false
    end 
  end
  
  def distribution_card_player(points)
    @card_player = points    
    @player_points += pack_parity[card_player]
    
    check_golden_point(card_player)    
    remove_the_precipitated_card(card_player)
    
    report_the_number_of_points_at_the_player(machine_points, player_points)
  end

  def distribution_card_machine(points)
    report_card_distribution_machine

    @card_machine = points
    @machine_points += pack_parity[card_machine]
    
    check_golden_point(card_machine)
    remove_the_precipitated_card(card_machine)
    
    report_the_number_of_points_at_the_machine(machine_points, player_points)
  end
    
  def get_a_random_number
    pack_parity.keys[rand(pack_parity.size)]
  end
  
  def check_golden_point(card)
    if card == card_machine
      @golden_point_machine += 1 if pack_parity[card] == 11
    else
      @golden_point_player += 1 if pack_parity[card] == 11
    end
  end
  
  def remove_the_precipitated_card(card)
    @pack_parity = @pack_parity.delete_if { |key, value| key == card }
  end
  
  def color_card(card)
    color_card = card.chars
    color_card.pop
    color_card.join + @card_suit[card.chars.last].chr
  end  
  
  def inform_the_result_of_the_game
    printer_results = PrinterResults.new(machine_points, player_points, golden_point_machine, golden_point_player)
    printer_results.result_games
  end
end

black_jack = BlackJack.new
black_jack.game
