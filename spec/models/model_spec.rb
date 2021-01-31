require_relative '../../src/models/model'

RSpec.describe Model do
  describe '#all' do
    it 'returns an empty list from an empty database' do
      allow(File).to receive(:read).with('talent.json').and_return('[]')
      expect(Model.all).to eq []
    end

    it 'returns Models from stored data' do
      talent = [
        { name: 'Bojack Horseman', location: 'Hollywoo', date_of_birth: '1964-01-02' },
        { name: 'Hank Hill', location: 'Arian', date_of_birth: '1953-04-15' }
      ]
      allow(File).to receive(:read).with('talent.json').and_return(talent.to_json)

      talent = Model.all
      expect(talent).to match_array [have_attributes(name: 'Bojack Horseman', location: 'Hollywoo', date_of_birth: '1964-01-02'),
                                     have_attributes(name: 'Hank Hill', location: 'Arian', date_of_birth: '1953-04-15')]
    end
  end

  describe '#find_by_location' do
    it 'returns all models for nil location' do
      talent = [
        { name: 'Bojack Horseman', location: 'Hollywoo', date_of_birth: '1964-01-02' },
        { name: 'Hank Hill', location: 'Arian', date_of_birth: '1953-04-15' },
        { name: 'Diane Nguyen', location: 'Hollywoo', date_of_birth: '1980-03-19' }
      ]
      allow(File).to receive(:read).with('talent.json').and_return(talent.to_json)

      talent = Model.find_by_location(nil)
      expect(talent).to match_array [
        have_attributes(name: 'Bojack Horseman', location: 'Hollywoo', date_of_birth: '1964-01-02'),
        have_attributes(name: 'Hank Hill', location: 'Arian', date_of_birth: '1953-04-15'),
        have_attributes(name: 'Diane Nguyen', location: 'Hollywoo', date_of_birth: '1980-03-19')
      ]
    end

    it 'returns matching models for a location' do
      talent = [
        { name: 'Bojack Horseman', location: 'Hollywoo', date_of_birth: '1964-01-02' },
        { name: 'Hank Hill', location: 'Arian', date_of_birth: '1953-04-15' },
        { name: 'Diane Nguyen', location: 'Hollywoo', date_of_birth: '1980-03-19' }
      ]
      allow(File).to receive(:read).with('talent.json').and_return(talent.to_json)

      talent = Model.find_by_location('Hollywoo')
      expect(talent).to match_array [
        have_attributes(name: 'Bojack Horseman', location: 'Hollywoo', date_of_birth: '1964-01-02'),
        have_attributes(name: 'Diane Nguyen', location: 'Hollywoo', date_of_birth: '1980-03-19')
      ]
    end

    it 'returns models for a location without case sensitivity' do
      talent = [
        { name: 'Bojack Horseman', location: 'Hollywoo', date_of_birth: '1964-01-02' },
        { name: 'Hank Hill', location: 'Arian', date_of_birth: '1953-04-15' },
        { name: 'Diane Nguyen', location: 'Hollywoo', date_of_birth: '1980-03-19' }
      ]
      allow(File).to receive(:read).with('talent.json').and_return(talent.to_json)

      talent = Model.find_by_location('HOLLYWOO')
      expect(talent).to match_array [
        have_attributes(name: 'Bojack Horseman', location: 'Hollywoo', date_of_birth: '1964-01-02'),
        have_attributes(name: 'Diane Nguyen', location: 'Hollywoo', date_of_birth: '1980-03-19')
      ]
    end

    it 'returns no models for location with no talent' do
      talent = [
        { name: 'Bojack Horseman', location: 'Hollywoo', date_of_birth: '1964-01-02' },
        { name: 'Hank Hill', location: 'Arian', date_of_birth: '1953-04-15' },
        { name: 'Diane Nguyen', location: 'Hollywoo', date_of_birth: '1980-03-19' }
      ]
      allow(File).to receive(:read).with('talent.json').and_return(talent.to_json)

      talent = Model.find_by_location('Shelbyville')
      expect(talent).to eq []
    end

    it 'treats empty location string like no location' do
      talent = [
        { name: 'Bojack Horseman', location: 'Hollywoo', date_of_birth: '1964-01-02' },
        { name: 'Hank Hill', location: 'Arian', date_of_birth: '1953-04-15' },
        { name: 'Diane Nguyen', location: 'Hollywoo', date_of_birth: '1980-03-19' }
      ]
      allow(File).to receive(:read).with('talent.json').and_return(talent.to_json)

      talent = Model.find_by_location('')
      expect(talent).to match_array [
        have_attributes(name: 'Bojack Horseman', location: 'Hollywoo', date_of_birth: '1964-01-02'),
        have_attributes(name: 'Hank Hill', location: 'Arian', date_of_birth: '1953-04-15'),
        have_attributes(name: 'Diane Nguyen', location: 'Hollywoo', date_of_birth: '1980-03-19')
      ]
    end
  end
end
