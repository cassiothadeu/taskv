class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title, null: false
      t.datetime :completed_at
      t.belongs_to :user, index: true, null: false

      t.timestamps
    end

    add_foreign_key :tasks, :users
  end
end
