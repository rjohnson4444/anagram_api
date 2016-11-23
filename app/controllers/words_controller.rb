class WordsController < ApplicationController
  respond_to :json

  attr_accessor :parsed_params

  before_filter :parse_request, :create_dictionary

  def create
    CorpusService.add(parsed_params["words"])
    head :created
  end

  def destroy
    CorpusService.delete_word(params)
    head :ok
  end

  private

    def parse_request
      @parsed_params ||= JSON.parse(request.body.read) unless request.body.read.empty?
    end

    def create_dictionary
      CorpusService.create_dictionary
    end
end
