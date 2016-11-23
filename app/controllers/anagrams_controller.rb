class AnagramsController < ApplicationController
  respond_to :json

  def show
    respond_with CorpusService.anagrams(params)
  end

  def destroy
    CorpusService.delete_all_words
    head :no_content
  end
end
