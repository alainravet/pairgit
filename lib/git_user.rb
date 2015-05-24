require 'digest/md5'
class GitUser < Struct.new(:name, :email)
  def self.current
    user_email = `git config --global --get user.email`.chomp
    user_name  = `git config --global --get user.name`.chomp
    new(user_name, user_email)
  end

  def self.from_attributes(hash)
    user_email = hash[:email]
    user_name  = hash[:name]
    new(user_name, user_email)
  end
  
  def avatar_url
    gravatar_id = Digest::MD5::hexdigest(email).downcase
    "http://gravatar.com/avatar/#{gravatar_id}.png"
  end
end
