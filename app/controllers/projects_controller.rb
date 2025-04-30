class ProjectsController < ApplicationController
  def index
    config = Config.find(params[:config_id])

    client = config.api_client

    response = client.get("api/v4/projects",
      simple: true, # Returns only limited fields for each project
      page: params[:page],
      search: params[:search],
      order_by: "name",
      sort: "asc",
    )

    if response.success?
      projects = Api::Project.parse_projects(response.body)
      pagination = Api::Pagination.new(response.raw)

      respond_to do
        it.html { render :index, locals: {projects:, pagination:, config:} }
      end
    else
      # handle bad response
    end
  end

  def show
    config = Config.find(params[:config_id])

    client = config.api_client
    response = client.get("api/v4/projects/#{params[:id]}")

    if response.success?
      project = Api::Project.parse_projects(response.body)

      respond_to do
        it.html { render :show, locals: {project:, config:} }
      end
    else
      # handle bad response
    end
  end
end
