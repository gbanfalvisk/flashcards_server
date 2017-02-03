class Deck < ApplicationRecord
    belongs_to :user, inverse_of: :decks
    has_many :deckCards, dependent: :destroy, inverse_of: :deck
    has_many :cards, through: :deckCards

    def card_count
        cards.size
    end
end
