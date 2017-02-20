module BlackJack
  class ActionsWhisCardDeck
    attr_reader :golden_point_player, :golden_point_machine, :card_deck

    def initialize
      @golden_point_machine = 0
      @golden_point_player  = 0

      @card_deck = {
        '6S'  => 6, '6H'  => 6, '6C'  => 6,  '6D'  => 6,  '7S' => 7,  '7H' => 7, '7C' => 7, '7D' => 7,
        '8S'  => 8, '8H'  => 8, '8C'  => 8,  '8D'  => 8,  '9S' => 9,  '9H' => 9, '9C' => 9, '9D' => 9,
        '10S' => 10,'10H' => 10,'10C' => 10, '10D' => 10, 'JS' => 2,  'JH' => 2, 'JC' => 2,
        'JD'  => 2, 'QS'  => 3, 'QH'  => 3,  'QC'  => 3,  'QD' => 3,  'KS' => 4, 'KH' => 4,
        'KC'  => 4, 'KD'  => 4, 'AS'  => 11, 'AH'  => 11, 'AC' => 11, 'AD' => 11
      }
    end

    def get_cards_points(card)
      card_deck[card]
    end

    def get_a_random_number
      card_deck.keys[rand(card_deck.size)]
    end

    def check_golden_point_machine(card)
      @golden_point_machine += 1 if card_deck[card] == 11
    end

    def check_golden_point_player(card)
      @golden_point_player += 1 if card_deck[card] == 11
    end

    def remove_the_precipitated_card(card)
      @card_deck = @card_deck.delete_if { |key, value| key == card }
    end
  end
end
