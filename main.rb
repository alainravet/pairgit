#require 'rubygems'
#require 'bundler/setup'

require 'cuba'
require "cuba/safe"
require 'cuba/render'
Cuba.plugin Cuba::Safe
Cuba.plugin(Cuba::Render)
require 'erb'

#require 'securerandom' ; puts SecureRandom.urlsafe_base64(44)
Cuba.use Rack::Session::Cookie, :secret => 'kXqb5TFnCYeg393UotH5yVNesNBHxAa1OJXAeQN4fMjdfne229CP5c1Wzgc'

Dir["lib/**/*.rb"          ].sort.each { |f| require_relative f }
Dir["helpers/**/*helper.rb"].sort.each { |f| require_relative f }

Cuba.define do
  def res_write(s)
    res.write s
    clear_flash
  end


  on get do
    # -----------------------------------
    # serve css files
    # -----------------------------------
    on "styles", extension("css") do |file|
      res.write File.open("styles/#{file}.css").read
    end

    on root do
      res_write view 'main', {
        solos:    Config.solos,
        pairs:    Config.pairs,
        current:  GitUser.current
      }
    end
  end

  on post do
    # POST with data like user[fname]=John&user[lname]=Doe
    on terminal('set_current') do 
      on param('name'), param('email') do |name, email|
        user = GitUser.new(name, email)
        if user
          set_notice('success' + " User #{user.name.inspect} is the new current git user")
        else
          set_notice('failure')
        end
        
        res.redirect "/"
      end
      on true do
        res.write "ERROR: You need to provide a name and an email"
      end
    end
  end
end

require 'launchy'
Launchy.open "http://localhost:9292/"
