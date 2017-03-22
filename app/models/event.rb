class Event < ActiveRecord::Base
  belongs_to :host, class_name: "User", foreign_key: "host_id"
  has_many :users, through: 'Attendees'
  has_many :comments

  validates :name, :city, :state, presence: true
  validates_date :date, :on_or_after => :today, :on_or_after_message => "Must be on or after today."
end
