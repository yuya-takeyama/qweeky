class PagesController < ApplicationController
  # GET /pages/*path
  def show
    page = Page.find_by(path: "/#{params[:path]}")

    if page
      render status: :ok,
        json: {
          content: page.revisions.last.content,
        }
    else
      render status: :not_found,
        json: {
          error: 'Not found',
        }
    end
  end

  # PATCH/PUT /pages/*path
  def update
    ApplicationRecord.transaction do
      @page = Page.find_or_create_by!(path: "/#{params[:path]}")
      @page.revisions.create!(user: current_user, content: params[:content])
    end
  end

  private
    def page_params
      params.require(:page).permit(:content)
    end
end
