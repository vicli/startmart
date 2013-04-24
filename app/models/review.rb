class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :reviewable, :polymorphic => true
  attr_accessible :body, :rating, :reviewable_id, :reviewable_type, :title
end