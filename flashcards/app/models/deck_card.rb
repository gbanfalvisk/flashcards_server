class DeckCard < ApplicationRecord
    belongs_to :user
    belongs_to :card
    belongs_to :deck

    validates :card, uniqueness: { scope: :deck, message: "One card per deck" }
end
