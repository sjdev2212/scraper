require 'test_helper'

class ScrapTest < ActiveSupport::TestCase
  test 'should not save scrap without csv_file_name' do
    scrap = Scrap.new(user_id: 1)
    assert_not scrap.save
  end
  test 'should not save scrap without user_id' do
    scrap = Scrap.new(csv_file_name: 'some.csv')
    assert_not scrap.save
  end
  test 'should not save scrap with invalid csv_file_name' do
    scrap = Scrap.new(csv_file_name: 'some')
    assert_not scrap.save
  end
  test 'should not save scrap with invalid user_id' do
    scrap = Scrap.new(csv_file_name: 'some.csv', user_id: 'some')
    assert_not scrap.save
  end
end
