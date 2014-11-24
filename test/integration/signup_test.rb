require 'test_helper'

class SignupTest < ActionDispatch::IntegrationTest
  test 'with valid data' do
    visit root_path

    click_link t('menu.signup')
    fill_in label('user.name'), with: 'Mary Doe'
    fill_in label('user.email'), with: 'mary@example.org'
    fill_in label('user.login'), with: 'mary'
    fill_in label('user.password'), with: 'test'
    fill_in label('user.password_confirmation'), with: 'test'
    click_button button('user.create')

    assert_equal login_path, current_path
    assert page.has_text?(notice('signup.create'))
  end

  test 'with invalid data' do
    visit root_path

    click_link t('menu.signup')
    click_button button('user.create')

    assert_equal signup_path, current_path
    assert page.has_text?(form_error_message)
  end
end
