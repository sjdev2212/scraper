require 'test_helper'

class ScrapDetailsControllerTest < ActionDispatch::IntegrationTest
  test 'shouldnt create a scrap_detail  without scprap_id' do
    assert_no_difference 'ScrapDetail.count' do
      scrap_detail = ScrapDetail.create(addWords: 22, links: 15, stats: 'some', html_cache: 'some', query: 'some',
                                        id: 1)
      assert_not scrap_detail.valid?
    end
  end
  test 'shouldnt create a scrap_detail without addWords' do
    assert_no_difference 'ScrapDetail.count' do
      scrap_detail = ScrapDetail.create(scrap_id: 1, links: 15, stats: 'some', html_cache: 'some', query: 'some',
                                        id: 1)
      assert_not scrap_detail.valid?
    end
  end
  test 'shouldnt create a scrap_detail without links' do
    assert_no_difference 'ScrapDetail.count' do
      scrap_detail = ScrapDetail.create(scrap_id: 1, addWords: 22, stats: 'some', html_cache: 'some', query: 'some',
                                        id: 1)
      assert_not scrap_detail.valid?
    end
  end
  test 'shouldnt create a scrap_detail without stats' do
    assert_no_difference 'ScrapDetail.count' do
      scrap_detail = ScrapDetail.create(scrap_id: 1, addWords: 22, links: 15, html_cache: 'some', query: 'some', id: 1)
      assert_not scrap_detail.valid?
    end
  end
  test 'shouldnt create a scrap_detail without html_cache' do
    assert_no_difference 'ScrapDetail.count' do
      scrap_detail = ScrapDetail.create(scrap_id: 1, addWords: 22, links: 15, stats: 'some', query: 'some', id: 1)
      assert_not scrap_detail.valid?
    end
  end
  test 'shouldnt create a scrap_detail without query' do
    assert_no_difference 'ScrapDetail.count' do
      scrap_detail = ScrapDetail.create(scrap_id: 1, addWords: 22, links: 15, stats: 'some', html_cache: 'some', id: 1)
      assert_not scrap_detail.valid?
    end
  end
end
