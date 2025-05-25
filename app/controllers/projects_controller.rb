# typed: strict

class ProjectsController < ApplicationController
  extend T::Sig

  sig { void }
  def index
    config = find_config

    respond_to do |f|
      f.html { render :index, locals: { config: } }
    end
  end

  sig { void }
  def projects_list
    config = find_config
    client = config.api_client

    response = client.get("api/v4/projects",
      simple: true, # Returns only limited fields for each project
      page: params[:page],
      search: params[:search],
      order_by: "name",
      per_page: 24,
      sort: "asc",
    )

    if response.success?
      projects = Projects::ProjectParser.parse(response.body)
      pagination = Common::Pagination.new(response.raw)

      respond_to do |f|
        f.html { render :projects_list, locals: { projects:, pagination:, config: } }
      end
    else
      # handle bad response
    end
  end

  sig { void }
  def members_preview
    config = find_config
    client = config.api_client

    response = client.get("api/v4/projects/#{params[:id]}/members/all",
      page: 1,
      per_page: 10,
    )

    if response.success?
      members = Members::MemberParser.parse(response.body)

      respond_to do |f|
        f.html { render :members_preview, locals: { members: } }
      end
    else
      # handle bad response
    end
  end

  sig { void }
  def merge_requests_size
    config = find_config
    client = config.api_client

    response = client.get("api/v4/projects/#{params[:id]}/merge_requests",
      page: 1,
      per_page: 1,
    )

    if response.success?
      merge_requests_size = response.raw["X-Total"]&.to_i

      respond_to do |f|
        f.html { render :merge_requests_size, locals: { merge_requests_size: } }
      end
    else
      # handle bad response
    end
  end

  sig { void }
  def show
    config = find_config
    client = config.api_client

    response = client.get("api/v4/projects/#{params[:id]}")

    if response.success?
      project = Projects::ProjectParser.parse(response.body)

      respond_to do |f|
        f.html { render :show, locals: { project:, config: } }
      end
    else
      # handle bad response
    end
  end

  private

  sig { returns(Config) }
  def find_config
    Config.find(params[:config_id])
  end
end
