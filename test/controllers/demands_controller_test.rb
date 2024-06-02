require "test_helper"

class DemandsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @demand = demands(:one)
  end

  test "should get index" do
    get demands_url, as: :json
    assert_response :success
  end

  test "should create demand" do
    assert_difference("Demand.count") do
      post demands_url, params: { demand: { demandaProyectada: @demand.demandaProyectada, demandaReal: @demand.demandaReal } }, as: :json
    end

    assert_response :created
  end

  test "should show demand" do
    get demand_url(@demand), as: :json
    assert_response :success
  end

  test "should update demand" do
    patch demand_url(@demand), params: { demand: { demandaProyectada: @demand.demandaProyectada, demandaReal: @demand.demandaReal } }, as: :json
    assert_response :success
  end

  test "should destroy demand" do
    assert_difference("Demand.count", -1) do
      delete demand_url(@demand), as: :json
    end

    assert_response :no_content
  end
end
