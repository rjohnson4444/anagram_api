require 'test_helper'

class AnagramsControllerTest < ActionController::TestCase
  test "#show responds to json" do
    get :show, word: 'read', format: :json

    assert_response :success
  end

  test "#show returns a hash" do
    get :show, word: 'read', format: :json

    assert_kind_of Hash, json_response
  end

  test "#show returns a hash with an array of anagrams" do
    get :show, word: 'read', format: :json

    assert_kind_of Array, json_response["anagrams"]
  end

  test "#show returns anagrams from added words" do
    words = ['read']
    CorpusService.create_dictionary
    CorpusService.add(words)
    get :show, word: 'read', format: :json

    assert_equal 4, json_response["anagrams"].count
  end

  test "#destroy responds to json" do
    delete :destroy, format: :json

    assert_response :no_content
  end

end
