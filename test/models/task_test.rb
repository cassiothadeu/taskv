require 'test_helper'

class TaskTest < ActiveSupport::TestCase
  test 'requires title' do
    task = Task.create(title: '')
    refute task.errors[:title].empty?
  end

  test 'requires user' do
    task = Task.create(user: nil)
    refute task.errors[:user].empty?
  end

  test 'detects task as pending' do
    task = Task.new(completed_at: nil)

    assert task.pending?
    refute task.complete?
    assert_equal 'pending', task.status
  end

  test 'detects task as complete' do
    task = Task.new(completed_at: Time.now)

    assert task.complete?
    refute task.pending?
    assert_equal 'complete', task.status
  end
end
