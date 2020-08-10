class User < ApplicationRecord
  after_create :welcome_send_mail

  has_many :gossips
  belongs_to :city, optional: true
  has_many :sent_messages, foreign_key: 'sender_id', class_name: "PrivateMessage"
  has_many :received_messages, foreign_key: 'recipient_id', class_name: "PrivateMessage"
  has_many :comments, as: :commentable
  has_many :likes, dependent: :destroy

  validates :email,
  presence: true,
  uniqueness: true,
  format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "email adress please" }
  validates :password, :presence =>true, :confirmation => true, :length => { :within => 6..40 }, :on => :create
  validates :password, :confirmation => true, :length => { :within => 6..40 }, :on => :update, :unless => lambda{ |user| user.password.blank? }
  # Encrypt password automatique by Bcrypt with attribute: password_digest
  has_secure_password 

  def remember(remember_token)
    remember_digest = BCrypt::Password.create(remember_token)
    self.update(remember_digest: remember_digest)
  end



  before_create :set_full_name
  before_create :get_username
  before_update :set_full_name

  private
  def set_full_name
    if self.first_name.nil? && self.last_name.nil? 
      self.full_name = self.email.split('@')[0].capitalize
    else
      self.full_name = "#{self.first_name.capitalize unless self.first_name.nil?} #{self.last_name.capitalize unless self.last_name.nil?}".strip
    end
  end
  def get_username
    if self.username.nil? || self.username.length < 1
      self.username = self.email.split('@')[0]
    end
  end
  def welcome_send_mail
    UserMailer.welcome_email(self).deliver_now
  end

end
