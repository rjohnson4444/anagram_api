require 'test_helper'

class WordsControllerTest < ActionController::TestCase
  test "#create responds to json" do
    post :create, words: ['read', 'dare'], format: :json

    assert_response :created
  end

  test "#destroy responds to json" do
    delete :destroy, word: 'read', format: :json

    assert_response :success
  end
end
