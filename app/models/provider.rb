class Provider < ApplicationRecord
  validates :npi, presence: true, uniqueness: true
end
