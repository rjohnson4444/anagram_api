class AnagramsController < ApplicationController
  respond_to :json

  def show
    respond_with CorpusService.anagrams(params)
  end

  def delete
  end
end
