require 'black_jack/printer_results'
require 'black_jack/ask'
require 'black_jack/actions_whis_card_deck'

class BlackJack
  attr_reader :player_points, :machine_points, :continue_game, :distribution, :ask, :actions_whis_card_deck

  def initialize
    @player_points          = 0
    @machine_points         = 0
    @continue_game          = true
    @distribution           = "Yes"

    @ask                    = Ask.new
    @actions_whis_card_deck = ActionsWhisCardDeck.new
  end

  def game
    ask.welcome_player
    perform_first_hand_of_cards
    perform_the_remaining_cards_are_dealt
    inform_the_result_of_the_game
  end

  private

  def perform_first_hand_of_cards
    distribution_card_player(actions_whis_card_deck.get_a_random_number)
    distribution_card_machine(actions_whis_card_deck.get_a_random_number)
  end

  def perform_the_remaining_cards_are_dealt
    while check_the_condition_of_the_continuation_of_the_game
      gameplay
    end

    ask.report_on_completion_of_the_game(machine_points, player_points)
  end

  def check_the_condition_of_the_continuation_of_the_game
    continue_game == true && player_points < 21 && machine_points < 21 || machine_points < 19 && player_points < 21 && machine_points <= player_points
  end

  def gameplay
    if continue_game == true && player_points < 21
      @distribution = ask.get_the_answer_player
      to_continue_a_game?
    end

    distribution_card_machine(actions_whis_card_deck.get_a_random_number) if continue_game == true || machine_points <= player_points
  end

  def to_continue_a_game?
    if distribution == 'yes' || distribution == 'Yes'
      distribution_card_player(actions_whis_card_deck.get_a_random_number)
    else
      @continue_game = false
    end
  end

  def distribution_card_player(card)
    @player_points += actions_whis_card_deck.get_cards_points(card)

    actions_whis_card_deck.check_golden_point_player(card)
    actions_whis_card_deck.remove_the_precipitated_card(card)

    ask.report_the_number_of_points_at_the_player(card, player_points)
  end

  def distribution_card_machine(card)
    ask.report_card_distribution_machine

    @machine_points += actions_whis_card_deck.get_cards_points(card)

    actions_whis_card_deck.check_golden_point_machine(card)
    actions_whis_card_deck.remove_the_precipitated_card(card)

    ask.report_the_number_of_points_at_the_machine(card, machine_points)
  end

  def golden_point_machine
    actions_whis_card_deck.golden_point_machine
  end

  def golden_point_player
    actions_whis_card_deck.golden_point_player
  end

  def inform_the_result_of_the_game
    printer_results = PrinterResults.new(machine_points, player_points, golden_point_machine, golden_point_player)
    printer_results.result_games
  end
end
