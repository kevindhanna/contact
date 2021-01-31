class Model
  attr_reader :name, :location, :date_of_birth
  TALENT = 'talent.json'

  def self.all
    s = File.read(TALENT)
    talent = JSON.parse(s)
    talent.map do |model|
      self.new(model['name'], model['location'], model['date_of_birth'])
    end
  end

  def initialize(name, location, date_of_birth)
    @name = name
    @location = location
    @date_of_birth = date_of_birth
  end
end
