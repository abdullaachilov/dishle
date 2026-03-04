class User < ApplicationRecord
  has_secure_password

  has_many :game_results, dependent: :destroy

  validates :nickname, presence: true, uniqueness: true,
            length: { minimum: 3, maximum: 20 },
            format: { with: /\A[a-zA-Z0-9_]+\z/, message: "only allows letters, numbers, and underscores" }
  validates :password, length: { minimum: 8 }, if: -> { password.present? }

  before_create :generate_session_token

  def generate_session_token!
    token = SecureRandom.urlsafe_base64(32)
    update!(session_token: token)
    token
  end

  def invalidate_session!
    update!(session_token: nil)
  end

  private

  def generate_session_token
    self.session_token = SecureRandom.urlsafe_base64(32)
  end
end
