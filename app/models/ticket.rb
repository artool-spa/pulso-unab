class Ticket < ApplicationRecord
    belongs_to :person
    has_many :mailers
    has_many :answers
end
