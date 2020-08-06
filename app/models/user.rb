require 'bcrypt'

class User < ApplicationRecord
  has_many :gossips
  belongs_to :city, optional: true
  has_many :sent_messages, foreign_key: 'sender_id', class_name: "PrivateMessage"
  has_many :received_messages, foreign_key: 'recipient_id', class_name: "PrivateMessage"
  has_many :comments, as: :commentable

  validates :email,
  presence: true,
  uniqueness: true,
  format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "email adress please" }
  validates :password, presence: true, length: { minimum: 6 }

  has_secure_password # Encrypt password automatique by Bcrypt with attribute: password_digest
  # def password
  #   @password ||= Password.new(password_digest)
  # end

  # def password=(new_password)
  #   @password = Password.create(new_password)
  #   selft.password_digest = @password
  # end

  before_create :set_full_name
  before_create :get_username
  before_update :set_full_name

  private
  def set_full_name
    if self.first_name.nil? && self.last_name.nil? 
      self.full_name = self.email.split('@')[0]
    else
      self.full_name = "#{self.first_name} #{self.last_name}".strip
    end
  end
  def get_username
    self.username = self.email.split('@')[0]
  end

end
