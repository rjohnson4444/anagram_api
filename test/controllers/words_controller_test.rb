require 'test_helper'

class WordsControllerTest < ActionController::TestCase
  test "#create responds to json" do
    post :create, words: ['read', 'dare'], format: :json

    assert_response :created
  end

  test "#create returns an error message if wrong/mispelled params are sent" do
    post :create, worded: ['read'], format: :json
    expected_response = { "error" => { "status" => 400, "message" => "Unable to process your request." } }

    assert_equal expected_response, json_response
  end

  test "#destroy responds to json" do
    delete :destroy, word: 'read', format: :json

    assert_response :success
  end

end
