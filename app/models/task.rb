class Task < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :title, :user

  scope :order_by_pending, -> {
    order('completed_at NULLS FIRST, title ASC')
  }

  scope :pending_count, -> {
    where(completed_at: nil).count
  }

  def complete?
    completed_at?
  end

  def pending?
    !complete?
  end

  def status
    complete? ? 'complete' : 'pending'
  end
end
