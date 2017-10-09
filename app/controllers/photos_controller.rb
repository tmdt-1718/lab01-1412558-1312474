class PhotosController < ApplicationController
  def index
  end
  def new
  end
  def create
    @photo = Photo.new(photo_params)
    @photo.num_views = 0

    if @photo.save
      flash[:success] = 'Your photo was uploaded'
    else
      flash[:danger] = "Need image before uploaded"
    end
  end

  def destroy
    @photo = Photo.find(params[:id])
    @album = @photo.album
    Cloudinary::Uploader.destroy(@photo.img.file.public_id)
    @photo.destroy
    flash[:danger] = "Image was successfully deleted"
    redirect_to  album_path(@album)
  end

  private
  def photo_params
    params.require(:photo).permit(:cover, :album_id)
  end

  def require_same_user
    if current_user != @photo.album.user and !current_user.admin?
      flash[:danger] = "You can only delete your own photo"
      redirect_to album_path(@phto.album)
    end
  end
end
