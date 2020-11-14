class Player < ApplicationRecord
    validates :username, presence: true
    validates :email, presence: true, uniqueness: true
    validates :password, presence: true
    has_one :game
end
