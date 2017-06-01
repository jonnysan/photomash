class PhotosController < ApplicationController
  def index
    @photos = Photo.all.sort_by{|t| t.rating}.reverse

    render("photos/index.html.erb")
  end

  def show
    @photo = Photo.find(params[:id])
    @wins = Showdown.where(winner_id: params[:id]).count
    @losses = Showdown.where(loser_id: params[:id]).count
    render("photos/show.html.erb")
  end

  def new
    @photo = Photo.new

    render("photos/new.html.erb")
  end

  def create
    @photo = Photo.new

    @photo.user_id = params[:user_id]
    @photo.rating = params[:rating]
    @photo.image_url = params[:image_url]

    save_status = @photo.save

    if save_status == true
      redirect_to("/photos/new", :notice => "Photo created successfully.")
    else
      render("photos/new.html.erb")
    end
  end

  def edit
    @photo = Photo.find(params[:id])

    render("photos/edit.html.erb")
  end

  def update
    @photo = Photo.find(params[:id])

    @photo.user_id = params[:user_id]
    @photo.rating = params[:rating]
    @photo.image_url = params[:image_url]

    save_status = @photo.save

    if save_status == true
      redirect_to("/photos/#{@photo.id}", :notice => "Photo updated successfully.")
    else
      render("photos/edit.html.erb")
    end
  end

  def destroy
    @photo = Photo.find(params[:id])

    @photo.destroy

    if URI(request.referer).path == "/photos/#{@photo.id}"
      redirect_to("/", :notice => "Photo deleted.")
    else
      redirect_to(:back, :notice => "Photo deleted.")
    end
  end
end
