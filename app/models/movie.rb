class Movie < ApplicationRecord
    has_many :movie
    has_many :user
end
