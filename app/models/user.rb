class User < ActiveRecord::Base

  has_and_belongs_to_many :projects

  has_secure_password

  attr_accessible :first_name, :last_name, :email, :password, :password_confirmation, :project_ids

  validates :first_name, :last_name, :email, :presence => true
  validates :email, :uniqueness => { :case_sensitive => false, :scope => :deleted_at }

  before_create { generate_token(:auth_token) }

  default_scope :conditions => { :deleted_at => nil }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def admin?
    is_admin
  end

  def full_name
    "#{first_name} #{last_name}"
  end

  def self.authenticate(email, password)
    find_by_email(email).try(:authenticate, password)
  end

  def self.find_with_destroyed *args
    self.with_exclusive_scope { find(*args) }
  end

  def self.find_only_destroyed
    self.with_exclusive_scope :find => { :conditions => "deleted_at is NOT NULL" } do
      all
    end
  end

  def destroy
    self.update_attribute(:deleted_at, Time.now.utc)
  end

  def send_password_reset
    generate_token(:password_reset_token)
    self.password_reset_sent_at = Time.zone.now
    save!
    UserMailer.password_reset(self).deliver
  end

end
