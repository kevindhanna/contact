require 'json'

step 'test' do
  puts 'here'
end

module TalentSteps
  TALENT_JSON = 'talent.json'

  step 'there is a valid talent JSON containing the following users:' do |table|
    s = File.read(TALENT_JSON)
    talent = JSON.parse(s)

    table.hashes.each do |row|
      talent.each do |model|
        expect(row).to be(model) if row['name'] == model['name']
      end
    end
  end

  step 'I request to see all the talent' do
    visit '/talent'
  end

  step 'I request to see all talent in :location' do |location|
    visit "/talent?location=#{location}"
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
end

RSpec.configure { |c| c.include TalentSteps }
