class Model
  attr_reader :name, :location, :date_of_birth

  TALENT = 'talent.json'

  def self.all
    talent = read_file
    talent.map do |model|
      new(model['name'], model['location'], model['date_of_birth'])
    end
  end

  def self.find_by_location(location)
    return all if location.nil? || location.empty?

    talent = read_file
    talent.filter_map do |model|
      new(model['name'], model['location'], model['date_of_birth']) if model['location'].downcase == location.downcase
    end
  end

  def self.read_file
    s = File.read(TALENT)
    JSON.parse(s)
  end

  def initialize(name, location, date_of_birth)
    @name = name
    @location = location
    @date_of_birth = date_of_birth
  end

  private_class_method :read_file
end
