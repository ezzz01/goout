class FeedUpdater < Post 
  require 'feedzirra'

 def self.update_feeds   
   feeds_array = update_feed_addresses
   loop_and_update(feeds_array)
 end

 def self.update_feed_addresses
  feeds_array = Array.new
  feed_urls = User.find(:all, :select => "blog_url").map { |user| user.blog_url }
  feed_urls.compact!
  feed_urls.each do |feed_url| 
      feed = Feedzirra::Feed.fetch_and_parse(feed_url)   
      feeds_array << feed
      add_entries(feed.entries, feed.url)
  end
  feeds_array
 end

 def self.loop_and_update(feeds_array)
 puts 'entering loop_and_update'
  loop do
    puts "trying to update"
      feeds_array.each do |feed| 
        feed = Feedzirra::Feed.update(feed)
          if feed.updated?   
            puts "updated"
            feed2 = Feedzirra::Feed.fetch_and_parse(feed.feed_url)   
            puts feed.new_entries.inspect
            add_entries(feed.new_entries, feed.url)
            feeds_array.delete(feed)
            feeds_array.push(feed2)
            loop_and_update(feeds_array)
          end
      end   
    sleep 60 
  end
 end   

def self.add_entries(entries, from_url)
      entries.each do |entry|   
    unless exists? :guid => entry.id   
#       if title is null (like all of my blog entries)
        entry.title = entry.id unless entry.title
        entry.content = entry.content ||= entry.summary
        Post.create!(   
          :title      => entry.title,   
          :body       => entry.content,   
          :url        => entry.url,   
          :created_at => entry.published,   
          :user_id    => 1013,
          :from_url   => from_url,
          :guid       => entry.id,
          :cached_tag_list => entry.categories.join(", ") 
        )   
      end   
    end
  end
end
