class AddMaxlengthToVoteFields < ActiveRecord::Migration
  def change
  	change_column :posts, :votes, :integer, :default => 0
  	change_column :posts, :name, :string, :maxlength => 200
  	change_column :posts, :url, :string, :maxlength => 2000
  end
end
