class PostTag < ActiveRecord::Base
  belongs_to :post
  belongs_to :tag

  validates_uniqueness_of :posttag_id, :scope => [:post_id, :tag_id]
end
