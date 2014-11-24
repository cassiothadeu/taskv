ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'minitest/pride'

I18n.locale = ENV.fetch('LOCALE', I18n.default_locale)

I18n.exception_handler = proc do |scope, *args|
  message = scope.to_s
  raise message unless message.include?(".i18n.plural.rule")
end

module IntegrationHelpers
  def login_as(user)
    visit root_path
    click_link t('menu.login')
    fill_in label('login.credential'), with: user.login
    fill_in label('login.password'), with: 'test'
    click_button button('login')
  end

  def t(*args)
    I18n.t(*args)
  end

  def label(scope)
    t(scope, scope: 'labels')
  end

  def button(scope)
    t(scope, scope: 'helpers.submit')
  end

  def alert(scope)
    t("flash.#{scope}.alert")
  end

  def notice(scope)
    t("flash.#{scope}.notice")
  end

  def form_error_message
    t('form_error_message')
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include IntegrationHelpers

  def teardown
    Capybara.reset_sessions!
  end
end

class ActiveSupport::TestCase
  fixtures :all
end
