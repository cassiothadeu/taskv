require 'test_helper'

class RemoveTaskTest < ActionDispatch::IntegrationTest
  test 'when removing task' do
    user = users(:john)
    login_as(user)

    within('.task:first-of-type') { click_link t('actions.remove') }
    click_button t('actions.im_sure')

    assert_equal tasks_path, current_path
    assert page.has_text?(notice('tasks.destroy'))
  end
end
