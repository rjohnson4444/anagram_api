class WordsController < ApplicationController
  respond_to :json

  attr_accessor :parsed_params

  before_filter :parse_request

  def create
    CorpusService.add(parsed_params["words"])
    head :created
  end

  def destoy
  end

  private

    def parse_request
      @parsed_params ||= JSON.parse(request.body.read)
    end
end
