require "test_helper"

class MarketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @market = markets(:one)
    @myrole = 'admin'
    @email = '0@gmail.com'
    @password = "0"
    get '/login/create', params: { email: @email, password: @password }
  end

  test "should get index" do
    get markets_url
    assert_response :success
  end

  test "should get new" do
    get new_market_url
    assert_response :success
  end

  test "should create market" do
    assert_difference("Market.count") do
      post markets_url, params: { market: { item_id: @market.item_id, price: @market.price, stock: @market.stock, user_id: @market.user_id } }
    end

    assert_redirected_to market_url(Market.last)
  end

  test "should show market" do
    get market_url(@market)
    assert_response :success
  end

  test "should get edit" do
    get edit_market_url(@market)
    assert_response :success
  end

  test "should update market" do
    patch market_url(@market), params: { market: { item_id: @market.item_id, price: @market.price, stock: @market.stock, user_id: @market.user_id } }
    assert_redirected_to market_url(@market)
  end

  test "should destroy market" do
    assert_difference("Market.count", -1) do
      delete market_url(@market)
    end

    assert_redirected_to markets_url
  end

  test "locking" do
    i1 = Market.find(markets(:one).id)
    i2 = Market.find(markets(:one).id)

    i1.price = 999
    i1.save

    assert_raises("Attempted to update a stale object: Inventory.") do
      i2.price = 888
      i2.save
    end
  end

end
