class PagesController < ApplicationController
  # GET /pages/*path
  def show
    set_page

    render json: @page
  end

  # PATCH/PUT /pages/*path
  def update
    set_page

    if @page.update(page_params)
      render json: @page
    else
      render json: @page.errors, status: :unprocessable_entity
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_page
      @page = Page.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def page_params
      params.require(:page).permit(:path)
    end
end
