# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  require 'string'
  require 'rss/1.0'
  require 'rss/2.0'
  require 'open-uri'
  require 'socket'

  def render_rss_feed(url)
    content = ""
    open(url, 0) do |s| content = s.read end
    feed = RSS::Parser.parse(content, false)
    @link = feed.channel.link
    @title = feed.channel.title
    @items = feed.channel.items[0..4] # just use the first five items
    render :partial => 'posts/rss_view'
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

end
