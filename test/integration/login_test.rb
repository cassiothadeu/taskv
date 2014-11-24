require 'test_helper'

class LoginTest < ActionDispatch::IntegrationTest
  test 'with valid credentials (using login)' do
    user = users(:john)
    login_as(user)

    assert_equal tasks_path, current_path
    assert page.has_text?(t('general.greeting', name: user.name))
  end

  test 'with valid credentials (using email)' do
    user = users(:john)
    login_as(user)

    assert_equal tasks_path, current_path
    assert page.has_text?(t('general.greeting', name: user.name))
  end

  test 'with invalid credentials' do
    visit root_path
    click_link t('menu.login')
    click_button button('login')

    assert_equal login_path, current_path
    assert page.has_text?(alert('login.create'))
  end
end
