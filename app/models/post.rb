class Post < ActiveRecord::Base
	validates_presence_of :name, :url, :username
	belongs_to :user
	has_reputation :votes, source: :user, aggregated_by: :sum
end
