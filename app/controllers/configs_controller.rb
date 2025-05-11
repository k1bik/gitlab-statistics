# typed: strict

class ConfigsController < ApplicationController
  extend T::Sig

  sig { void }
  def show
    config = Config.find(params[:id])

    respond_to do |f|
      f.html { render :show, locals: { config: } }
    end
  end
end
