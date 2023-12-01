require 'rails_helper'

RSpec.describe ScrapDetail, type: :model do
  subject do
    user = User.new(
      name: "name",
      email: 'asdas@asd.com',
      password: 'password',
      id: 1,
    )
    user.save
    Scrap.new(
      user_id: 1,
      id: 1,
      csv_file_name: 'search',
      queries: ['query1', 'query2'],
    )
    ScrapDetail.new(
      scrap_id: 1,
      query: 'query1',
      addWords: 1,
      stats: 'stats',
      links: 1,
      html_cache: 'html_cache',
      id: 1,
    )
  end

  it 'addwords is an integer' do
    subject.addWords = nil
    expect(subject).to_not be_valid
  end

  it 'stats is a string' do
    subject.stats.instance_of? String
    expect(subject).to_not be_valid
  end
  it 'links is an integer' do
    subject.links.instance_of? Array
    expect(subject).to_not be_valid
  end
  it 'html_cache is a string' do
    !subject.html_cache.instance_of? String
    expect(subject).to_not be_valid
  end
  it 'it should have a scrap_id' do
    subject.scrap_id = nil
    expect(subject).to_not be_valid
  end
  it 'it should have a query' do
    subject.query = nil
    expect(subject).to_not be_valid
  end
end
