class AddCanPublishToUsers < ActiveRecord::Migration
  def change
    add_column :users, :can_publish, :boolean
  end
end
