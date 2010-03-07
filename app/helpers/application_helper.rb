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
    @concepts and @concepts.length > 1
  end

  def profile_for(user)
    user
  end

  def profile_link(user)
    link_to user.username, user_path(user.username)
  end

  def current_user
    User.find(session[:user_id])
  end

  def avatar_for(user, thumb = true)
    if user.avatar
        if thumb == true
            avatar_image = user.avatar.public_filename(:small)
            link_to image_tag(avatar_image), user_path(user) 
        else 
            avatar_image = user.avatar.public_filename
            link_to image_tag(avatar_image), user.avatar.public_filename
        end
    end
  end

####################################
# instiki helpers
####################################

  # Accepts a container (hash, array, enumerable, your type) and returns a string of option tags. Given a container 
  # where the elements respond to first and last (such as a two-element array), the "lasts" serve as option values and
  # the "firsts" as option text. Hashes are turned into this form automatically, so the keys become "firsts" and values
  # become lasts. If +selected+ is specified, the matching "last" or element will get the selected option-tag.
  #
  # Examples (call, result):
  #   html_options([["Dollar", "$"], ["Kroner", "DKK"]])
  #     <option value="$">Dollar</option>\n<option value="DKK">Kroner</option>
  #
  #   html_options([ "VISA", "Mastercard" ], "Mastercard")
  #     <option>VISA</option>\n<option selected>Mastercard</option>
  #
  #   html_options({ "Basic" => "$20", "Plus" => "$40" }, "$40")
  #     <option value="$20">Basic</option>\n<option value="$40" selected>Plus</option>

  def html_options(container, selected = nil)
    container = container.to_a if Hash === container
  
    html_options = container.inject([]) do |options, element| 
      if element.is_a? Array
        if element.last != selected
          options << "<option value=\"#{element.last}\">#{element.first}</option>"
        else
          options << "<option value=\"#{element.last}\" selected=\"selected\">#{element.first}</option>"
        end
      else
        options << ((element != selected) ? "<option>#{element}</option>" : "<option selected>#{element}</option>")
      end
    end
    
    html_options.join("\n")
  end

  # Creates a hyperlink to a Wiki page, without checking if the concept exists or not
  def link_to_existing_concept(concept, text = nil, html_options = {})
    link_to(
        text || concept.plain_name, 
        {:action => 'show', :id => concept.title, :only_path => true},
        html_options)
  end
  
  # Creates a hyperlink to a Wiki page, or to a "new page" form if the concept doesn't exist yet
  def link_to_concept(concept_title, text = nil, options = {})
    UrlGenerator.new(@controller).make_link(concept_title, text)
  end

  def author_link(concept, options = {})
#   UrlGenerator.new(@controller).make_link(concept.author.name, nil, options)
  end

  # Create a hyperlink to a particular revision of a Wiki page
  def link_to_revision(concept, revision_number, text = nil, mode = nil, html_options = {})
    revision_number == concept.revisions.size ?
      link_to(
        text || concept.plain_name,
            {:action => 'show', :id => concept.title,
               :mode => mode}, html_options) :
      link_to(
        text || concept.plain_name + "(rev # #{revision_number})",
            {:action => 'revision', :id => concept.title,
              :rev => revision_number, :mode => mode}, html_options)
  end

  # Create a hyperlink to the history of a particular Wiki page
  def link_to_history(concept, text = nil, html_options = {})
    link_to(
        text || concept.plain_name + "(history)",
            {:action => 'history', :id => concept.title},
            html_options)
  end

  def base_url
    #home_page_url = url_for :controller => 'admin', :action => 'create_system', :only_path => true
#   home_page_url.sub(%r-/create_system/?$-, '')
  end

  # Creates a menu of categories
  def categories_menu
    if @categories.empty?
      ''
    else 
      "<div id=\"categories\">\n" +
      '<strong>Categories</strong>:' +
      '[' + link_to_unless_current('Any', :action => self.action_name, :category => nil) + "]\n" +
      @categories.map { |c| 
        link_to_unless_current(c, :action => self.action_name, :category => c)
      }.join(', ') + "\n" +
      '</div>'
    end
  end

  def wiki_first_page_menu
      @categories.map { |c| 
        link_to(c.capitalize, :action => self.action_name, :category => c)
      }.join('<br />') 
  end

  # Performs HTML escaping on text, but keeps linefeeds intact (by replacing them with <br/>)
  def escape_preserving_linefeeds(text)
    h(text).gsub(/\n/, '<br/>').as_utf8
  end

  def format_date(date, include_time = true)
    # Must use DateTime because Time doesn't support %e on at least some platforms
    if include_time
      DateTime.new(date.year, date.mon, date.day, date.hour, date.min, date.sec).strftime("%B %e, %Y %H:%M:%S")
    else
      DateTime.new(date.year, date.mon, date.day).strftime("%B %e, %Y")
    end
  end

  def rendered_content(concept)
    PageRenderer.new(concept.revisions.last).display_content
  end

  def truncate(text, *args)
    options = args.extract_options!
    options.reverse_merge!(:length => 30, :omission => "...")
    return text if text.num_chars <= options[:length]
    len = options[:length] - options[:omission].as_utf8.num_chars
    t = ''
    text.split.collect do |word|
      if t.num_chars + word.num_chars <= len
        t << word + ' '
      else 
        return t.chop + options[:omission]
      end
    end
  end

end
