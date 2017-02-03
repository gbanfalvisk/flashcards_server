class DeckCardSerializer < ActiveModel::Serializer
  attributes :id, :deck, :card

  def deck
    object.deck.id
  end

  def card
    object.card.id
  end
end
