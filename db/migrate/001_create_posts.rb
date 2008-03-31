class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title
      t.text :body

      # The id of the User who created the Post.
      t.integer :user_id

      # This might night be needed, since you can just override
      # 'to_param' in the model.
      # t.string :permalink

      # Automagically creates 'created_at' and 'updated_at' fields.
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
