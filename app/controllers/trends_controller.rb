class TrendsController < ApplicationController
  def show
    render json: { message: TrendsService.new.get }
  end
end