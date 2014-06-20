class Post < ActiveRecord::Base
	validates_presence_of :name, :url, :username, :votes
	
end
