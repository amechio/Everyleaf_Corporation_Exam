class AddLimitToTasks < ActiveRecord::Migration[5.2]
  def change
    add_column :tasks, :limit, :date, null: false, default: -> { 'NOW()' }
  end
end
