class AddColumRemerberDigest < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :remember_digest, :string
    add_column :users, :avatar, :string
  end
end
