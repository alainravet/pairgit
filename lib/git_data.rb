require_relative 'config_store'

class GitData < Struct.new(:solos, :pairs)
  def self.solos ; ConfigStore.get_all(:solos) end
  def self.pairs ; ConfigStore.get_all(:pairs) end
end
