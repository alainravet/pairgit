require 'webrick'
module PathHelper

  def terminal(path)
    /#{path}\/?\z/
  end
    
  def users_path
    "/users"
  end
    
  def set_current_path(git_user)
    escaped_name  = WEBrick::HTTPUtils.escape(git_user.name )
    escaped_email = WEBrick::HTTPUtils.escape(git_user.email)
    "/set_current?name=#{escaped_name}&email=#{escaped_email}"
  end
end

Cuba.plugin PathHelper
