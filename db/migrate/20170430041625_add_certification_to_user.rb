class AddCertificationToUser < ActiveRecord::Migration
  def change
    add_column :users, :certificated, :boolean
  end
end
