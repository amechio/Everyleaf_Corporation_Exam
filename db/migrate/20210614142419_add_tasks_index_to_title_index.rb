class AddTasksIndexToTitleIndex < ActiveRecord::Migration[5.2]
  def change
    add_index :tasks, :title, name: "index_tasks_on_title"
  end
end
