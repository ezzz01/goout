class SiteController < ApplicationController

  def index
		  @title = "Start page"
  end

  def about
		 @title = "About page" 
  end

  def help
		  @title = "Help page"
  end
end
