class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :username
      t.string :pass_hash
      t.boolean :admin 
      t.string :email
      t.string :salt
      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
