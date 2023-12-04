require 'test_helper'

class ScrapTest < ActiveSupport::TestCase
  test "shouldn't create a scrap without csv_file_name" do
    assert_no_difference 'Scrap.count' do
      scrap = Scrap.create(user_id: 1, queries: ['some'])
      assert_not scrap.valid?
    end
  end
  test "shouldn't create a scrap without user_id" do
    assert_no_difference 'Scrap.count' do
      scrap = Scrap.create(csv_file_name: 'some', queries: ['some'])
      assert_not scrap.valid?
    end
  end
  test "shouldn't create a scrap without queries" do
    assert_no_difference 'Scrap.count' do
      scrap = Scrap.create(csv_file_name: 'some', user_id: 1)
      assert_not scrap.valid?
    end
  end
end
