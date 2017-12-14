class AddWriterStatusToUser < ActiveRecord::Migration
  def change
    add_column :users, :writer_status, :integer
  end
end
