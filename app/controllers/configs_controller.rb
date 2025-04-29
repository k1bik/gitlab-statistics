class ConfigsController < ApplicationController
  def show
    config = Config.find(params[:id])

    respond_to do
      it.html { render :show, locals: {config:} }
    end
  end
end
