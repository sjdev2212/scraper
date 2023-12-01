require 'rails_helper'

RSpec.describe User, type: :model do
  subject do
    User.new(
      name: "name",
      email: 'some@som.com',
      password: 'password',
    )
  end

  before { subject.save }

  it 'should have a name' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'should have an email' do
    subject.email = nil
    expect(subject).to_not be_valid
  end

  it 'should have a password' do
    subject.password = nil
    expect(subject).to_not be_valid
  end
end
