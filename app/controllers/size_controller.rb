class SizeController < ApplicationController
  def index
    sql = Size.all

    if request.xhr?
      render :json => {
          :file_content => sql
      }
    end
  end

  def create
    input = params[:size]
    if input!=nil
      sized = Size.where(name:input).first_or_create
    end
    if request.xhr?
      render :json => {
          :file_content => sized
      }
    end
  end

end
