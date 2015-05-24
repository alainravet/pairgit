require 'webrick'
module SessionHelper

  def flash
    session['flash'] ||= {}
  end

  def notice
    session['flash'] && session['flash']['notice']
  end
  
  def set_notice(message)
    flash['notice'] = message
  end
end

Cuba.plugin SessionHelper
