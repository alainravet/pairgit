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
    # GET /styles/main.css
    on "styles", extension("css") do |file|
      res.write File.open(File.expand_path("views/styles/#{file}.css", File.dirname(__FILE__))).read
    end
    on "js", extension("js") do |file|
      res.headers['Content-Type'] = 'application/javascript'
      res.write File.open(File.expand_path("views/js/#{file}.js", File.dirname(__FILE__))).read
    end

    on root do
      res_write view 'main', {
        solos:    GitData.solos,
        pairs:    GitData.pairs,
        current:  GitUser.get_current
      }
    end
  end

  on post do
    # POST /set_current
    on terminal('set_current') do 
      on param('name'), param('email'), param('group') do |name, email|
        user = GitUser.new(name, email)
        user.set_current

        set_notice('success' + " User #{user.name.inspect} is the new current git user")
        res.redirect "/"
      end
      on true do
        res.write "ERROR: You need to provide a name and an email"
      end
    end
    

    on terminal('add_new_pair') do 
      on param('name'), param('email') do |name, email|
puts "1:  param('name') = #{param('name').inspect}"
puts "1:  param('email') = #{param('email').inspect}"

        user = GitUser.new(name, email)
puts "2:  user = #{user.inspect}"
        user.set_current
        #TODO : persist in the Yaml Store, if not already known
        set_notice('success' + " Pair #{user.name.inspect} is the new current git user")
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
