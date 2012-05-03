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
  end
end
