require 'rubygems'
require 'bundler/setup'

require 'cuba'
require 'rack/protection'

Cuba.use Rack::Session::Cookie, :secret => '__a_very_long_string__'
Cuba.use Rack::Protection

require 'digest/md5'
def avatar_url(email)
  gravatar_id = Digest::MD5::hexdigest(email).downcase
  "http://gravatar.com/avatar/#{gravatar_id}.png"
end
  Cuba.define do
  on get do
    on root do
      user_email = `git config --global --get user.email`.chomp
      user_name  = `git config --global --get user.name`.chomp
      res.write "
      <html>
        <body>
          <p>user.email = #{user_email}</p>
          <p>user.name = #{user_name}</p>
            <img src='#{avatar_url(user_email)}'>
        </body>
      </html>
      "
    end
  end
end

require 'launchy'
Launchy.open "http://localhost:9292/"
