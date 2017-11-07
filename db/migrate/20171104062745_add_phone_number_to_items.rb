class AddPhoneNumberToItems < ActiveRecord::Migration
  def change
    add_column :items, :phonenumber, :text
  end
end
