class FeedUpdater < Post 
  require 'feedzirra'

 def self.update_feeds   
   $logfile = File.open(File.dirname(__FILE__) + "/../../log/feed_updater.log", 'a')    
   $feed_updater_log = FeedUpdaterLogger.new($logfile) 
   $feed_updater_log.info("Starting updating feeds")
   @error_count = 0
   @loop_count = 0
   feeds_array = update_feed_addresses
   loop_and_update(feeds_array)
 end

 def self.update_feed_addresses
  feeds_array = Array.new
  feed_urls = User.find(:all, :select => "blog_url", :conditions => "blog_url != ''").map { |user| user.blog_url }
  feed_urls.each do |feed_url| 
     begin 
       feed = Feedzirra::Feed.fetch_and_parse(feed_url)   
       feeds_array << feed
       add_entries(feed.entries, feed.url) 
     rescue Exception => e 
        $feed_updater_log.error("Exception: " + e.message + " " + feed_url)
     end
  end
  feeds_array
 end

 def self.loop_and_update(feeds_array)
  loop do
    puts "trying to update"
      feeds_array.each do |feed| 
        begin
        feed = Feedzirra::Feed.update(feed)
          if feed.updated?   
            feed2 = Feedzirra::Feed.fetch_and_parse(feed.feed_url)   
            $feed_updater_log.info("Updated from: " + feed.feed_url)
            add_entries(feed.new_entries, feed.url)
            feeds_array.delete(feed)
            feeds_array.push(feed2)
            loop_and_update(feeds_array)
          end
        rescue Exception => e
          @error_count += @error_count
          $feed_updater_log.error("Exception in subsequent update : " + e.message + " " + feed.feed_url)
        end
      end   
    $logfile.flush
    #is there is some repetitive error, try starting from the beginning
    if @error_count > 10
      $feed_updater_log.info("10 Exceptions counted, restarting")
      update_feeds 
    end
    #once every hour we should check for new feeds. Unfortunately this means we have to go through all feeds and update them
    update_feed if @loop_count > 12 
    @loop_count += @loop_count
    sleep 300 
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
