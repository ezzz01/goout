# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  require 'string'
  require 'rss/1.0'
  require 'rss/2.0'
  require 'open-uri'
  require 'socket'
  require "rexml/document"
  include REXML

  def get_xml_feed(url)
    content = ""
    begin
      open(url, 0) do |s| content = s.read end
      doc = Document.new content

      #naive checking whether it's an atom or rss feed
      if (doc.root.name == "feed")
        feed_type = "atom"
      else
        feed_type = "rss"
      end

      @myposts = Array.new

      if feed_type == "rss"
        feed = RSS::Parser.parse(content, false) 
        @link = feed.channel.link
        #@title = feed.channel.title
        @items = feed.channel.items[0..10] # just use the first five items        
      elsif feed_type == "atom"
        doc.elements.each("feed/entry") do |s|
          @mypost = Post.new
          @mypost.title = s.elements["title"].text
          @mypost.link = s.elements["link"].attributes["href"]
          @mypost.body= s.elements["content"].text
          datetime = s.elements["published"].text
          @mypost.created_at = DateTime.parse(datetime).strftime('%Y%m%d %H:%M:%S')
          @myposts << @mypost
        end
        return @myposts
      end
          rescue 

          end
  end

  def tag_cloud(tags, classes)
    return if tags.empty?
    
    max_count = tags.sort_by(&:count).last.count.to_f
    
    tags.each do |tag|
      index = ((tag.count / max_count) * (classes.size - 1)).round
      yield tag, classes[index]
    end
  end

  # create link for navigation
  def nav_link(text, controller, action="index")
    link_to_unless_current text, :id => nil, :controller => controller, :action => action
  end

  # true if user logged in, false otherwise
  def logged_in?
    not session[:user_id].nil?
  end

  def text_field_for(form, field, size=HTML_TEXT_FIELD_SIZE, 
                     maxlength=DB_STRING_MAX_LENGTH, *value )
    label = content_tag("label", "#{field.humanize}:", :for => field)
    if value.empty?
      form_field = form.text_field field, :size => size, :maxlength => maxlength 
    else
      form_field = form.text_field field, :size => size, :maxlength => maxlength, :value => value 
    end
    content_tag("div", "#{label} #{form_field}", :class => "form_row")
  end

  def paginated?
    @pages and @pages.length > 1
  end

  def profile_for(user)
    user
  end

end
