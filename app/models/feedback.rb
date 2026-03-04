class Feedback < ApplicationRecord
  belongs_to :user, optional: true

  validates :body, presence: true, length: { maximum: 500 }
  validates :ip_address, presence: true, length: { maximum: 45 }
end
