class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :post_id
      t.text :body
      t.string :author
      t.string :email
      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  end
end
