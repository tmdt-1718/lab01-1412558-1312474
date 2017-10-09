class AlbumsController < ApplicationController

  def index
  end
  def index
       @albums = Album.paginate(page: params[:page], per_page: 5)
       @albums.each do |album|
            album.photos.each do |photo|
                album.num_views += photo.num_views
            end
        end
    end

    def new
        @album = Album.new
    end

    def create
        @album = Album.new(album_params)
        @album.user = current_user
        if @album.save
            flash[:success] = "Albums was successfully create"
            redirect_to album_path(@album)
        else
            render 'new'
        end
    end

    def show
        @photo = Photo.new
        @list_photos = @album.photos.paginate(page: params[:page], per_page: 9 )
        @list_photos.each do |photo|
            photo.update(num_views: photo.num_views + 1)
        end
    end

    def edit

    end

    def update
        if @album.update(album_params)
            flash[:success] = "Album was successfully update"
            redirect_to album_path(@album)
        else
            render 'edit'
        end
    end

    def destroy
        @album.destroy
        flash[:danger] = "Album was successfully deleted"
        redirect_to albums_path
    end

    private
        def set_album
            @album = Album.find(params[:id])
        end

        def album_params
            params.require(:album).permit(:name, :description, :cover)
        end

        def require_same_user
            if current_user != @album.user and !current_user.admin?
                flash[:danger] = "You can only edit or delete your own albums"
                redirect_to albums_path
            end
        end
end
end
