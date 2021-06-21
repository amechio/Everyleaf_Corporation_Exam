class ChangeColumnsAddNotNullOnLabellings < ActiveRecord::Migration[5.2]
  def change
    change_column :labellings, :task_id, :bigint, null: false
    change_column :labellings, :label_id, :bigint, null: false
  end
end
