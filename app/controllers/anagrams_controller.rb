class AnagramsController < ApplicationController
  respond_to :json

  def show
    respond_with CorpusService.anagrams(params[:word])
  end

  def delete
  end
end
