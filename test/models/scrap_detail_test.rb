require 'test_helper'

class ScrapDetailTest < ActiveSupport::TestCase
  test "should create a new scrap_detail" do
    assert_difference 'ScrapDetail.count', 1 do
      scrap_detail = ScrapDetail.create!(addWords: 'some', stats: 'some', links: 'some', html_cache: 'some',
                                         scrap_id: 1, id: 1, query: 'some')
      assert scrap_detail.valid?
    end
  end
  
  test "should not create scrap_detail with no scrap_id" do
    assert_no_difference 'ScrapDetail.count' do
      scrap_detail = ScrapDetail.create(addWords: 'some', stats: 'some', links: 'some',
                                        html_cache: 'some', scrap_id: '', id: 1)
      assert_not scrap_detail.valid?
    end
  end




end
