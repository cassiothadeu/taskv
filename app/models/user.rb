class User < ActiveRecord::Base
  validates_presence_of :name, :email
  # validates_size_of :password, minimum: 8
  validates_format_of :email,
    with: /\A[a-z0-9]+([._][a-z0-9]+)*(\+[^@]+)?@[a-z0-9]+([.-][a-z0-9]+)*\.[a-z]{2,4}\z/i

  validates_format_of :login,
    with: /\A[a-z0-9]+\z/i

  validates_uniqueness_of :login, :email

  has_secure_password

  has_many :tasks
end
