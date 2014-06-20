class AddDefaultToVotecount < ActiveRecord::Migration
  def change
  	change_column :posts, :votes, :integer, :default => 0
  end
end
