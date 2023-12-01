require 'test_helper'

class ScrapDetailTest < ActiveSupport::TestCase
  test 'should not save scrap_detail without scrap_id' do
    scrap_detail = ScrapDetail.new
    assert_not scrap_detail.save
  end
  test 'should not save scrap_detail without name' do
    scrap_detail = ScrapDetail.new(scrap_id: 1)
    assert_not scrap_detail.save
  end
  test 'addWords should be an integer' do
    scrap_detail = ScrapDetail.new(scrap_id: 1, addWords: 'some')
    assert_not scrap_detail.save
  end
  test 'stats should be a string' do
    scrap_detail = ScrapDetail.new(scrap_id: 1, stats: 1)
    assert_not scrap_detail.save
  end
  test 'links should be an integer' do
    scrap_detail = ScrapDetail.new(scrap_id: 1, links: 'some')
    assert_not scrap_detail.save
  end
  test 'html_cache should be a string' do
    scrap_detail = ScrapDetail.new(scrap_id: 1, html_cache: 1)
    assert_not scrap_detail.save
  end
  test 'query should be a string' do
    scrap_detail = ScrapDetail.new(scrap_id: 1, query: 1)
    assert_not scrap_detail.save
  end
end
