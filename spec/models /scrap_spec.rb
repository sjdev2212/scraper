require 'rails_helper'

RSpec.describe Scrap, type: :model do
  subject do
    user = User.new(
      name: "name",
      email: 'email@ex.com',
      password: 'password',
      id: 1,
    )
    user.save
    user.scraps.create(
      user_id: 1,
      id: 1,
      csv_file_name: 'search',
      queries: ['query1', 'query2'],
    )
  end

  it 'it should have a csv_file_name' do
    subject.csv_file_name = nil
    expect(subject).to_not be_valid
  end

  it 'csv_file_name should be a string' do
    subject.csv_file_name == 1
    expect(subject).to_not be_valid
  end

  it 'it should have a queries' do
    subject.queries = nil
    expect(subject).to_not be_valid
  end
end
