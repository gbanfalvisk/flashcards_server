class Card < ApplicationRecord
    belongs_to :user, inverse_of: :cards
    has_many :deckCards, dependent: :destroy, inverse_of: :card
    has_many :decks, through: :deckCards

    def deck_count
        decks.size
    end
end
