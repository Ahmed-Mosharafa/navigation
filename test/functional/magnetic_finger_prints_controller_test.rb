require 'test_helper'

class MagneticFingerPrintsControllerTest < ActionController::TestCase
  setup do
    @magnetic_finger_print = magnetic_finger_prints(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:magnetic_finger_prints)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create magnetic_finger_print" do
    assert_difference('MagneticFingerPrint.count') do
      post :create, magnetic_finger_print: { angle: @magnetic_finger_print.angle, magnetic_id: @magnetic_finger_print.magnetic_id, magnitude: @magnetic_finger_print.magnitude, place_id: @magnetic_finger_print.place_id, x: @magnetic_finger_print.x, y: @magnetic_finger_print.y, z: @magnetic_finger_print.z }
    end

    assert_redirected_to magnetic_finger_print_path(assigns(:magnetic_finger_print))
  end

  test "should show magnetic_finger_print" do
    get :show, id: @magnetic_finger_print
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @magnetic_finger_print
    assert_response :success
  end

  test "should update magnetic_finger_print" do
    put :update, id: @magnetic_finger_print, magnetic_finger_print: { angle: @magnetic_finger_print.angle, magnetic_id: @magnetic_finger_print.magnetic_id, magnitude: @magnetic_finger_print.magnitude, place_id: @magnetic_finger_print.place_id, x: @magnetic_finger_print.x, y: @magnetic_finger_print.y, z: @magnetic_finger_print.z }
    assert_redirected_to magnetic_finger_print_path(assigns(:magnetic_finger_print))
  end

  test "should destroy magnetic_finger_print" do
    assert_difference('MagneticFingerPrint.count', -1) do
      delete :destroy, id: @magnetic_finger_print
    end

    assert_redirected_to magnetic_finger_prints_path
  end
end
