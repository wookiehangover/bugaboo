class User < ActiveRecord::Base

  has_secure_password

  before_create { generate_token(:auth_token) }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end

  def admin?
    is_admin
  end

  def self.authenticate(email, password)
    find_by_email(email).try(:authenticate, password)
  end

end
