module ProfileHelper
  def profile_for(user)
    profile_url(:username => user.username)
  end
end
