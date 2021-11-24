class Restaurant < ApplicationRecord
  has_many :reviews, dependent: :destroy
  validates :name, :address,presence: true
  FGORY = ["chinese", "italian", "japanese", "french", "belgian"]
  validates :category, inclusion: { in: FGORY, allow_nil: false }
end
