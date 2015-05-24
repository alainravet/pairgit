#require 'rubygems'
#require 'bundler/setup'

require 'cuba'
require 'rack/protection'
#require 'securerandom' ; puts SecureRandom.urlsafe_base64(44)
Cuba.use Rack::Session::Cookie, :secret => 'kXqb5TFnCYeg393UotH5yVNesNBHxAa1OJXAeQN4fMjdfne229CP5c1Wzgc'
Cuba.use Rack::Protection

require 'cuba/render'
require 'erb'
Cuba.plugin(Cuba::Render)

Dir["lib/**/*.rb"].sort.each { |f| require_relative f }
Dir["helpers/**/*helper.rb"].sort.each { |f| require_relative f }


Cuba.define do
  on get do
    on root do
      res.write view 'main', {
        solos:    Config.solos,
        pairs:    Config.pairs,
        current:  GitUser.current
      }
    end
  end
end

require 'launchy'
Launchy.open "http://localhost:9292/"
