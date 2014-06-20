class CreateVotes < ActiveRecord::Migration
  def change
    create_table :votes do |t|
      t.integer :user_id
      t.integer :post_id
      t.boolean :is_upvote

      t.timestamps
    end
  end
end
