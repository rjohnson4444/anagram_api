class WordsController < ApplicationController
  respond_to :json

  attr_accessor :parsed_params

  before_filter :parse_request, :create_dictionary

  def create
    if parsed_params["words"]
      CorpusService.add(parsed_params["words"])
      head :created
    else
      render json: error_response
    end
  end

  def destroy
    CorpusService.delete_word(params)
    head :ok
  end

  private
    def error_response
      { error: {
                 status: 400,
                 message: "Unable to process your request."
               }
      }
    end

    def parse_request
      req            = request.body.read
      param_req      = JSON.parse(req) unless (req.include?("%") || req.empty?)
      @parsed_params = param_req.nil? ? params : param_req
    end

    def create_dictionary
      CorpusService.create_dictionary
    end
end
