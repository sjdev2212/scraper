require 'test_helper'

class ScrapDetailTest < ActiveSupport::TestCase
  test "should create a new scrap_detail" do
    assert_difference 'ScrapDetail.count', 1 do
      scrap_detail = ScrapDetail.create!(addWords: 'some', stats: 'some', links: 'some', html_cache: 'some',
                                         scrap_id: 1, id: 1, query: 'some')
      assert scrap_detail.valid?
    end
  end
  test "should not create scrap_detail with no addWords" do
    assert_no_difference 'ScrapDetail.count' do
      scrap_detail = ScrapDetail.create(addWords: '', stats: 'some', links: 'some', html_cache: 'some',
                                        scrap_id: 1, id: 1)
      assert_not scrap_detail.valid?
    end
  end
  test "should not create scrap_detail with no stats" do
    assert_no_difference 'ScrapDetail.count' do
      scrap_detail = ScrapDetail.create(addWords: 'some', stats: '', links: 'some', html_cache: 'some',
                                        scrap_id: 1, id: 1)
      assert_not scrap_detail.valid?
    end
  end
  test "should not create scrap_detail with no links" do
    assert_no_difference 'ScrapDetail.count' do
      scrap_detail = ScrapDetail.create(addWords: 'some', stats: 'some', links: '', html_cache: 'some',
                                        scrap_id: 1, id: 1)
      assert_not scrap_detail.valid?
    end
  end
  test "should not create scrap_detail with no html_cache" do
    assert_no_difference 'ScrapDetail.count' do
      scrap_detail = ScrapDetail.create(addWords: 'some', stats: 'some', links: 'some', html_cache: '',
                                        scrap_id: 1, id: 1)
      assert_not scrap_detail.valid?
    end
  end
  test "should not create scrap_detail with no scrap_id" do
    assert_no_difference 'ScrapDetail.count' do
      scrap_detail = ScrapDetail.create(addWords: 'some', stats: 'some', links: 'some',
                                        html_cache: 'some', scrap_id: '', id: 1)
      assert_not scrap_detail.valid?
    end
  end
  test "addWords should be an integer" do
    assert_no_difference 'ScrapDetail.count' do
      scrap_detail = ScrapDetail.create(addWords: 'some', stats: 'some', links: 'some',
                                        html_cache: 'some', scrap_id: 1, id: 1)
      assert_not scrap_detail.valid?
    end
  end
  test "stats should be a string" do
    assert_no_difference 'ScrapDetail.count' do
      scrap_detail = ScrapDetail.create(addWords: 1, stats: 1, links: 'some', html_cache: 'some',
                                        scrap_id: 1, id: 1)
      assert_not scrap_detail.valid?
    end
  end
  test "links should be an integer" do
    assert_no_difference 'ScrapDetail.count' do
      scrap_detail = ScrapDetail.create(addWords: 1, stats: 'some', links: 'some',
                                        html_cache: 'some', scrap_id: 1, id: 1)
      assert_not scrap_detail.valid?
    end
  end
  test "html_cache should be a string" do
    assert_no_difference 'ScrapDetail.count' do
      scrap_detail = ScrapDetail.create(addWords: 1, stats: 'some', links: 1, html_cache: 1,
                                        scrap_id: 1, id: 1)
      assert_not scrap_detail.valid?
    end
  end
end
