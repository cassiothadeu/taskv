class TaskList
  def self.update_completed_at(user, task_ids)
    Task.transaction do
      user.tasks
        .where(id: task_ids)
        .update_all(['completed_at = COALESCE(completed_at, ?)', Time.now])

      user.tasks
        .where.not(id: task_ids)
        .update_all(completed_at: nil)
    end
  end
end
