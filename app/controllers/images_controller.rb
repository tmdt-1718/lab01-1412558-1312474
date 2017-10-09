def index
    @images = Image.all
  end

  def create
    @album = Album.find(params[:album_id])
    if @album.user == current_user
      @image = Image.new(user_id: params[:user_id], album_id: params[:album_id], url: params[:image][:url])
      if @image.save
        redirect_to user_album_path(params[:user_id], params[:album_id]), notice: "Image uploads successfully."
      else
        redirect_to user_album_path(params[:user_id], params[:album_id]), alert: @image.errors
      end
    else
      redirect_to user_album_path(params[:user_id], params[:album_id]), alert: "You dont have permission to upload image to this album"
    end
  end

  def show
    @image.views += 1
    @image.album.total_views += 1
    @image.album.save
    @image.save
    render json: {image: @image, user: @image.user, html: image_info_html }, status: 200
  end

  def destroy
    @image = Image.find(params[:id])
    album = @image.album
    if current_user == @image.user
      album.total_views -= @image.views
      album.save
      @image.destroy
      redirect_to user_album_path(current_user, album)
    else
      redirect_to user_album_path(current_user, album), alert: "You dont have permission to delete image of this album"
    end
  end

  private
    def set_image
      begin
        @image = Image.find(params[:id])
      rescue => exception
        redirect_to '/404' and return
      end
    end

    def image_info_html
      result = gravatar_for(@image.user, size: 60) +
               "<h5><a href='/users/#{@image.user.id}/home'>" +
               "#{@image.user.name}</a></h5><div>Views: #{@image.views}</div>"
      if current_user == @image.user
        result += "<form method='post' id='album-cover' " +
                  "action='/users/#{@image.user.id}/albums/#{@image.album_id}/cover'>" +
                  "<input type='hidden' name='image_id' value='#{@image.id}'></form>" +
                  "<div><a href='#' id='changeCover'>Set album cover</a></div>" +
                  "<div><a data-method='delete' id='triggerDelete' " +
                  "href='/images/#{@image.id}'>Delete this photo</a></div>"
      end
      return CGI::unescapeHTML(result)
    end
end
