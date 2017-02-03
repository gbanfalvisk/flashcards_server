class DeckCardSerializer < ActiveModel::Serializer
  attributes :id, :user, :deck, :card

  def deck
    object.deck.id
  end

  def card
    object.card.id
  end

    def user
    object.user.id
  end
end
