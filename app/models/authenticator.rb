class Authenticator
  def self.authenticate(credential, password)
    new(credential, password).authenticate
  end

  attr_reader :credential, :password

  def initialize(credential, password)
    @credential = credential
    @password = password
  end

  def user
    @user ||= User.where(
      'email = :credential OR login = :credential',
      credential: credential
    ).first
  end

  # def user
  #   @user ||= User.where(
  #     'email = ? OR login = ?',
  #     credential, credential
  #   ).first
  # end

  def authenticate
    user && user.authenticate(password)
  end
end
