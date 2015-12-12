require 'test_helper'

class WifiFingerPrintsRecordsControllerTest < ActionController::TestCase
  setup do
    @wifi_finger_prints_record = wifi_finger_prints_records(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:wifi_finger_prints_records)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create wifi_finger_prints_record" do
    assert_difference('WifiFingerPrintsRecord.count') do
      post :create, wifi_finger_prints_record: { BSSID: @wifi_finger_prints_record.BSSID, RSSI: @wifi_finger_prints_record.RSSI, SSID: @wifi_finger_prints_record.SSID, channel: @wifi_finger_prints_record.channel, fingerprint_id: @wifi_finger_prints_record.fingerprint_id }
    end

    assert_redirected_to wifi_finger_prints_record_path(assigns(:wifi_finger_prints_record))
  end

  test "should show wifi_finger_prints_record" do
    get :show, id: @wifi_finger_prints_record
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @wifi_finger_prints_record
    assert_response :success
  end

  test "should update wifi_finger_prints_record" do
    put :update, id: @wifi_finger_prints_record, wifi_finger_prints_record: { BSSID: @wifi_finger_prints_record.BSSID, RSSI: @wifi_finger_prints_record.RSSI, SSID: @wifi_finger_prints_record.SSID, channel: @wifi_finger_prints_record.channel, fingerprint_id: @wifi_finger_prints_record.fingerprint_id }
    assert_redirected_to wifi_finger_prints_record_path(assigns(:wifi_finger_prints_record))
  end

  test "should destroy wifi_finger_prints_record" do
    assert_difference('WifiFingerPrintsRecord.count', -1) do
      delete :destroy, id: @wifi_finger_prints_record
    end

    assert_redirected_to wifi_finger_prints_records_path
  end
end
