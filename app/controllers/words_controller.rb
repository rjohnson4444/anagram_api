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
      req            = request.body.read
      param_req      = JSON.parse(req) unless (req.include?("%") || req.empty?)
      @parsed_params = param_req.nil? ? params : param_req
    end

    def create_dictionary
      CorpusService.create_dictionary
    end
end
