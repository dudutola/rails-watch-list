require 'open-uri'

class ListsController < ApplicationController
  def index
    @lists = List.all
  end

  def show
    @list = List.find(params[:id])
    @bookmarks = @list.bookmarks
  end

  def new
    @list = List.new
  end

  def create
    @list = List.new(list_params)

    if list_params[:image_url].present?
      downloaded_image = URI.open(list_params[:image_url])
      random_image_name = SecureRandom.hex(10)
      @list.image.attach(io: downloaded_image, filename: "#{random_image_name}.jpg")
    end

    if @list.save
      redirect_to @list
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def list_params
    params.require(:list).permit(:name, :image, :image_url)
  end
end
