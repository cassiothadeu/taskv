require 'test_helper'

class TaskBatchEditTest < ActionDispatch::IntegrationTest
  test 'updates task' do
    user = users(:john)
    login_as(user)

    within('.task.pending') { check tasks(:pending).title }
    within('.task.complete') { uncheck tasks(:complete).title }

    click_button button('update_all')

    assert_equal tasks_path, current_path

    # The pending task should be marked as completed now
    assert_equal tasks(:pending).title, find('.task.complete > label').text

    # The complete task should be marked as pending now
    assert_equal tasks(:complete).title, find('.task.pending > label').text
  end
end
