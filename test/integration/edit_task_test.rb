require 'test_helper'

class EditTaskTest < ActionDispatch::IntegrationTest
  test 'with valid data' do
    user = users(:john)
    login_as(user)

    within('.task:first-of-type') do
      click_link t('actions.edit')
    end

    fill_in label('task.title'), with: 'Updated task'
    click_button button('task.update')

    assert_equal tasks_path, current_path
    assert page.has_text?(notice('tasks.update'))
    assert page.has_text?('Updated task')
  end

  test 'with invalid data' do
    user = users(:john)
    login_as(user)

    within('.task:first-of-type') do
      click_link t('actions.edit')
    end

    fill_in label('task.title'), with: ''
    click_button button('task.update')

    assert_match %r[^/tasks/\d+/edit$], current_path
    assert page.has_text?(form_error_message)
  end
end
