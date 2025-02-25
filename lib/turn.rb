class Turn
  attr_reader :player1, :player2, :spoils_of_war
  def initialize(player1, player2)
    @player1 = player1
    @player2 = player2
    @spoils_of_war = []
  end

  def type
    if @player1.deck.rank_of_card_at(0) != @player2.deck.rank_of_card_at(0)
     :basic
    elsif @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0) && @player1.deck.rank_of_card_at(2) == @player2.deck.rank_of_card_at(2)
     :mutually_assured_destruction
    elsif @player1.deck.rank_of_card_at(0) == @player2.deck.rank_of_card_at(0)
     :war
    end
  end

  def winner
    type = type()
    if type == :basic && @player1.deck.rank_of_card_at(0) > @player2.deck.rank_of_card_at(0)
      player1
    elsif type == :basic && @player1.deck.rank_of_card_at(0) < @player2.deck.rank_of_card_at(0)
      player2
    elsif type == :war && @player1.deck.rank_of_card_at(2) > @player2.deck.rank_of_card_at(2)
      player1
    elsif type == :war && @player1.deck.rank_of_card_at(2) < @player2.deck.rank_of_card_at(2)
      player2
    elsif type == :mutually_assured_destruction && @player1.deck.rank_of_card_at(2) == @player2.deck.rank_of_card_at(2)
      "No Winner"
    end

  #   if @player1.deck.rank_of_card_at(0) > @player2.deck.rank_of_card_at(0)
  #     player1
  #   else
  #     player2
  #   end
  #   :war
  end

  def pile_cards
    if type == :basic
      @spoils_of_war << player1.deck.remove_card
      @spoils_of_war << player2.deck.remove_card
    elsif type == :war
      3.times do
        @spoils_of_war << player1.deck.remove_card
        @spoils_of_war << player2.deck.remove_card
      end
    elsif type == :mutually_assured_destruction
      3.times do
        player1.deck.remove_card
        player2.deck.remove_card
      end
    end
    # p @spoils_of_war
  end

  def award_spoils(winner)
    # binding.pry
    if winner == player1
      spoils_of_war.each do|spoils|
      player1.deck.cards << spoils
      end
    else
      spoils_of_war.each do|spoils|
      player2.deck.cards << spoils
      end
    end

  end

end
