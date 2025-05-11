class ProjectsController < ApplicationController
  def index
    config = get_config

    respond_to do
      it.html { render :index, locals: { config: } }
    end
  end

  def projects_list
    config = get_config
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
      projects = Api::Project.parse_projects(response.body)
      pagination = Api::Pagination.new(response.raw)

      respond_to do
        it.html { render :projects_list, locals: { projects:, pagination:, config: } }
      end
    else
      # handle bad response
    end
  end

  def members_size
    config = get_config
    client = config.api_client

    response = client.get("api/v4/projects/#{params[:id]}/members/all",
      page: 1,
      per_page: 1,
    )

    if response.success?
      members_size = response.raw["X-Total"]&.to_i

      respond_to do
        it.html { render :members_size, locals: { members_size: } }
      end
    else
      # handle bad response
    end
  end

  def show
    config = get_config
    client = config.api_client

    response = client.get("api/v4/projects/#{params[:id]}")

    if response.success?
      project = Api::Project.parse_projects(response.body)

      respond_to do
        it.html { render :show, locals: { project:, config: } }
      end
    else
      # handle bad response
    end
  end

  private

  def get_config
    Config.find(params[:config_id])
  end
end
