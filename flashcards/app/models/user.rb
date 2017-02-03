class User < ApplicationRecord
    has_secure_password

    has_many :sessions, dependent: :destroy, inverse_of: :user
    has_many :cards, dependent: :destroy, inverse_of: :user
    has_many :decks, dependent: :destroy, inverse_of: :user
    has_many :deckCards, dependent: :destroy, inverse_of: :user
    
    validates :email, uniqueness: true
    validates :password, length: { minimum: 8 }
end
