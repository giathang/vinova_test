class Post < ActiveRecord::Base
	belongs_to :catetogy
	has_many :comments,dependent: :destroy
end
