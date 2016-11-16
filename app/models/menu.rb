class Menu < ApplicationRecord
  has_many :orders
  belongs_to :drink
  belongs_to :type
  belongs_to :size
end