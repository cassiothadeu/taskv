require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'requires name' do
    user = User.create(name: '')
    refute user.errors[:name].empty?
  end

  test 'requires email' do
    user = User.create(email: '')
    refute user.errors[:email].empty?
  end

  %w[
    invalid
    a@a
    a @a.com
    --@example.org
    __@example.org
  ].each do |email|
    test %[rejects #{email} as email] do
      user = User.create(email: email)
      refute user.errors[:email].empty?
    end
  end

  %w[
    mary@example.org
    42@example.org
    john.doe@example.org
    john_doe@example.org
    john+spam@example.org
    john.doe_admin@example.org
    john@some-domain.org
    john@some.domain.org
    john@1234.org
    john@example.1234.org
    john@example.com.br
    john@example.co.uk
    john@example.info
    john@example.me
  ].each do |email|
    test %[accepts #{email} as email] do
      user = User.create(email: email)
      assert user.errors[:email].empty?
    end
  end

  test 'requires password' do
    user = User.create(password: '')
    refute user.errors[:password].empty?
  end

  test 'requires password confirmation' do
    user = User.create(password: 'test', password_confirmation: 'invalid')
    refute user.errors[:password_confirmation].empty?
  end

  %w[
    John_Doe
    John.Doe
    :)
  ].each do |login|
    test "rejects #{login} as login" do
      user = User.create(login: login)
      refute user.errors[:login].empty?
    end
  end

  %w[
    John
    john
    john123
    123john
    4242
  ].each do |login|
    test "accepts #{login} as login" do
      user = User.create(login: login)
      assert user.errors[:login].empty?
    end
  end

  test 'rejects duplicated login' do
    existing = users(:john)

    user = User.create(login: existing.login)
    refute user.errors[:login].empty?
  end

  test 'rejects duplicated email' do
    existing = users(:john)

    user = User.create(email: existing.email)
    refute user.errors[:email].empty?
  end

  # test 'requires a password with at least 8 chars' do
  #   user = User.create(password: 'test')
  #   refute user.errors[:password].empty?
  # end
end
