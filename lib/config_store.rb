require 'yaml'
require "yaml/store"

class ConfigStore
  def self.yaml_store(path=File.expand_path('~/.pairgit.yml'))
    @_instance = YAML::Store.new(path)    
  end

  def self.get_all(key)
    s = yaml_store
    s.transaction do 
      s[key]
    end
  end
  
  def self.add_pair(git_user)
    s = yaml_store
    s.transaction do 
      s[:pairs] << git_user
    end
  end
end
