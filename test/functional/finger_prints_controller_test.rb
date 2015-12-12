require 'test_helper'

class FingerPrintsControllerTest < ActionController::TestCase
  setup do
    @finger_print = finger_prints(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:finger_prints)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create finger_print" do
    assert_difference('FingerPrint.count') do
      post :create, finger_print: { BSSID: @finger_print.BSSID, MRSSI: @finger_print.MRSSI, SD: @finger_print.SD, SSID: @finger_print.SSID, place_id: @finger_print.place_id, xcoord: @finger_print.xcoord, ycoord: @finger_print.ycoord }
    end

    assert_redirected_to finger_print_path(assigns(:finger_print))
  end

  test "should show finger_print" do
    get :show, id: @finger_print
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @finger_print
    assert_response :success
  end

  test "should update finger_print" do
    put :update, id: @finger_print, finger_print: { BSSID: @finger_print.BSSID, MRSSI: @finger_print.MRSSI, SD: @finger_print.SD, SSID: @finger_print.SSID, place_id: @finger_print.place_id, xcoord: @finger_print.xcoord, ycoord: @finger_print.ycoord }
    assert_redirected_to finger_print_path(assigns(:finger_print))
  end

  test "should destroy finger_print" do
    assert_difference('FingerPrint.count', -1) do
      delete :destroy, id: @finger_print
    end

    assert_redirected_to finger_prints_path
  end
end
