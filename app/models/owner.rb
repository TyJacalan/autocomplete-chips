class Owner < ApplicationRecord
  has_many :animals, dependent: :destroy
end
