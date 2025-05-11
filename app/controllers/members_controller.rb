# typed: strict

class MembersController < ApplicationController
  extend T::Sig

  sig { void }
  def index
    config = Config.find(params[:config_id])

    page = params[:page] || 1
    client = config.api_client
    response = client.get("api/v4/projects/#{params[:project_id]}/members/all", page:)

    if response.success?
      members = Api::Member.parse_members(response.body)
      pagination = Api::Pagination.new(response.raw)

      respond_to do |f|
        f.html { render :index, locals: { members:, pagination:, config: } }
      end
    else
      # handle bad response
    end
  end
end
