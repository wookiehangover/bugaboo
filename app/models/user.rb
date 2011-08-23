class User < ActiveRecord::Base

  has_secure_password

  def admin?
    is_admin
  end

  def self.authenticate(email, password)
    find_by_email(email).try(:authenticate, password)
  end

end
