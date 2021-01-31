require 'json'

step 'test' do
  puts 'here'
end

module TalentSteps
  TALENT_JSON = 'talent.json'

  step 'there is a valid talent JSON containing the following users:' do |table|
    talent = table.hashes.map do |model|
      { name: model['Name'], location: model['Location'], date_of_birth: model['Date of Birth'] }
    end
    File.write(TALENT_JSON, talent.to_json)
  end

  step 'the talent JSON is empty' do
    File.write(TALENT_JSON, [].to_json)
  end

  step 'I request to see all the talent' do
    visit '/talent'
  end

  step 'I request to see all talent in :location' do |location|
    visit '/talent'
    fill_in 'location', with: location
    click_button 'filter'
  end

  step 'I request to see the root page' do
    visit '/'
  end
  step 'the platform should respond this request was successful' do
    expect(page.status_code).to eq(200)
  end

  step 'I should see :name' do |name|
    expect(page).to have_content name
  end

  step 'I should not see :name' do |name|
    expect(page).not_to have_content name
  end

  step 'I should be on the talent page' do
    # puts page.methods.sort
    expect(page.current_path).to eq '/talent'
  end

  step 'I should see no names' do
    s = File.read(TALENT_JSON)
    talent = JSON.parse(s)
    talent.each do |model|
      expect(page).not_to have_content(model['name'])
    end
  end
end

RSpec.configure { |c| c.include TalentSteps }
