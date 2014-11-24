require 'test_helper'

class LogoutTest < ActionDispatch::IntegrationTest
  test 'when logged in' do
    user = users(:john)
    login_as(user)
    click_button t('menu.logout')

    assert_equal root_path, current_path
  end
end
