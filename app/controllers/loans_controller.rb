class LoansController < ApplicationController
	respond_to :html, :json
  def newest
  	page = params[:page] || 1
  	response = HTTParty.get("http://api.kivaws.org/v1/loans/newest.json?page=#{page}")
  	respond_with response.body
  end

  def show
  end

  def search
    require 'countries'
    page = params[:page] || 1
    q = params[:q] || "United States"
    if params.has_key? :country
      country = params[:country].downcase
    else
      country = ""
    end
    response = HTTParty.get("http://api.kivaws.org/v1/loans/search.json?country_code=#{country}")
    respond_with response.body
  end
end
