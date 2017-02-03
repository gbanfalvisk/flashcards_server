class Session < ApplicationRecord
    belongs_to :user, inverse_of: :sessions
    has_secure_token
end
