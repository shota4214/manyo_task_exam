class AddDeadlineToTasks < ActiveRecord::Migration[6.0]
  def change
    add_column :tasks, :deadline, :date, default: -> {'NOW()' }, null: false
  end
end
