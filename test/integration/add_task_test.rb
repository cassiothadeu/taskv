require 'test_helper'

class AddTaskTest < ActionDispatch::IntegrationTest
  test 'when unlogged' do
    visit tasks_path
    assert_equal login_path, current_path
  end

  test 'with valid data' do
    user = users(:john)
    login_as(user)

    fill_in label('task.title'), with: 'Some task'
    click_button button('task.create')

    assert_equal tasks_path, current_path
    assert page.has_text?(notice('tasks.create'))
    assert page.has_text?('Some task')
  end

  test 'with invalid data' do
    user = users(:john)
    login_as(user)

    click_button button('task.create')

    assert_equal tasks_path, current_path
    assert page.has_text?(t('inline_errors', errors: ''))
  end
end
