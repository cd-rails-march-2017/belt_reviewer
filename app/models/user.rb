class User < ActiveRecord::Base
  has_secure_password
  attr_accessor :confirm_pw

  has_many :event_comments, through: :comments, source: :event, dependent: :destroy
  has_many :attendees
  has_many :attending, source: :event, through: :attendees

  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :first_name, :last_name, :city, :state, presence: true
  validates :email, uniqueness: { case_sensitive: false }, format: { with: EMAIL_REGEX }
  validates :password, length: { minimum: 8 }, on: :create
  validate :password_match

  protected
    def password_match
      if self.password != self.confirm_pw
        errors.add(:confirm_pw, "Passwords do not match")
      end
    end
end
