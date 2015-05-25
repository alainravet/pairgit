require 'digest/md5'
class GitUser < Struct.new(:name, :email)
  def self.get_current
    user_email = `git config --global --get user.email`.chomp
    user_name  = `git config --global --get user.name`.chomp
    new(user_name, user_email)
  end

  def self.from_attributes(hash)
    user_email = hash[:email]
    user_name  = hash[:name]
    new(user_name, user_email)
  end
  
  def set_current
    `git config --global user.email #{email}`
    `git config --global user.name  #{name}`
  end
  
  def avatar_url(options={})
    gravatar_id   = Digest::MD5::hexdigest(email).downcase

    query_strings = ['d=identicon']
    query_strings << "s=#{options[:size]}" if options[:size]
    query_string = query_strings.join('&')

    "http://gravatar.com/avatar/#{gravatar_id}.png?#{query_string}"
  end
end
