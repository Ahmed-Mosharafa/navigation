require 'test_helper'

class MagneticsControllerTest < ActionController::TestCase
  setup do
    @magnetic = magnetics(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:magnetics)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create magnetic" do
    assert_difference('Magnetic.count') do
      post :create, magnetic: { angle: @magnetic.angle, magnitude: @magnetic.magnitude, magnitudesd: @magnetic.magnitudesd, place_id: @magnetic.place_id, x: @magnetic.x, xcoord: @magnetic.xcoord, xsd: @magnetic.xsd, y: @magnetic.y, ycoord: @magnetic.ycoord, ysd: @magnetic.ysd, z: @magnetic.z, zsd: @magnetic.zsd }
    end

    assert_redirected_to magnetic_path(assigns(:magnetic))
  end

  test "should show magnetic" do
    get :show, id: @magnetic
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @magnetic
    assert_response :success
  end

  test "should update magnetic" do
    put :update, id: @magnetic, magnetic: { angle: @magnetic.angle, magnitude: @magnetic.magnitude, magnitudesd: @magnetic.magnitudesd, place_id: @magnetic.place_id, x: @magnetic.x, xcoord: @magnetic.xcoord, xsd: @magnetic.xsd, y: @magnetic.y, ycoord: @magnetic.ycoord, ysd: @magnetic.ysd, z: @magnetic.z, zsd: @magnetic.zsd }
    assert_redirected_to magnetic_path(assigns(:magnetic))
  end

  test "should destroy magnetic" do
    assert_difference('Magnetic.count', -1) do
      delete :destroy, id: @magnetic
    end

    assert_redirected_to magnetics_path
  end
end
