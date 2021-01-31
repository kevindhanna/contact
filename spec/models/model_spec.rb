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
      expect(talent).to match_array [
                          have_attributes(name: 'Bojack Horseman', location: 'Hollywoo', date_of_birth: '1964-01-02'),
                          have_attributes(name: 'Hank Hill', location: 'Arian', date_of_birth: '1953-04-15')
                        ]
    end
  end
end
