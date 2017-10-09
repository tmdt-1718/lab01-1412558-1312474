class AlbumsController < ApplicationController
  before_action :authenticate_user!, only: [:new]
  def index
    @albums = Album.all
  end
  def new
    @album = Album.new
  end

  def create
    @album = Album.new(album_params)
    @album.user = current_user
    @album.total_view = 0
    if @album.save
      flash[:success] = "Albums was successfully created"
      redirect_to album_path(@album)
    else
      render 'new'
    end
  end

  def show
  end

  def album_params
    params.require(:album).permit(:title, :cover)
  end
end
