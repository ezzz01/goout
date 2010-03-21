class Post < ActiveRecord::Base
  include ApplicationHelper
  require 'feedzirra'

  acts_as_taggable
  belongs_to :user
  has_many :comments, :order => "created_at", :dependent => :destroy
  alias_attribute :published, :created_at
  alias_attribute :content, :body
  attr_accessor :link
  attr_accessor :url

 validates_presence_of :body
 validates_length_of :title, :maximum => 100
 validates_length_of :body, :maximum => DB_TEXT_MAX_LENGTH
 validates_uniqueness_of :body, :scope => :title

  def duplicate?
    post = Post.find_by_user_id_and_title_and_body(user_id, title, body)
    self.id = post.id unless post.nil?
    not post.nil?
  end

  def self.update_from_feed(feed_url, user_id)   
    feed = Feedzirra::Feed.fetch_and_parse(feed_url)   
    feed.entries.each do |entry|   
      unless exists? :guid => entry.id   
#       if title is null (like all of my blog entries)
        entry.title = entry.id unless entry.title
        entry.content = entry.content ||= entry.summary
        create!(   
          :title      => entry.title,   
          :body       => entry.content,   
          :url        => entry.url,   
          :created_at => entry.published,   
          :user_id    => user_id,
          :from_url   => feed.url,
          :guid       => entry.id,
          :cached_tag_list => entry.categories.join(", ") 
        )   
      end   
    end   
  end   
end
