class ShowdownsController < ApplicationController
  def index
    @showdowns = Showdown.all

    render("showdowns/index.html.erb")
  end

  def show
    @showdown = Showdown.find(params[:id])

    render("showdowns/show.html.erb")
  end

  def new
    @showdown = Showdown.new
    @images = Photo.all.sample(2)
    @img1 = @images.first
    @img2 = @images.last
    render("showdowns/new.html.erb")
  end

  def create
    @showdown = Showdown.new

    @showdown.winner_id = params[:winner_id]
    @showdown.loser_id = params[:loser_id]
    @showdown.winner_oldrating = params[:winner_oldrating]
    @showdown.winner_newrating = params[:winner_newrating]
    @showdown.loser_oldrating = params[:loser_oldrating]
    @showdown.loser_newrating = params[:loser_newrating]

    save_status = @showdown.save

    if save_status == true
      redirect_to("/showdowns/#{@showdown.id}", :notice => "Showdown created successfully.")
    else
      render("showdowns/new.html.erb")
    end
  end

  def edit
    @showdown = Showdown.find(params[:id])

    render("showdowns/edit.html.erb")
  end

  def update
    @showdown = Showdown.find(params[:id])

    @showdown.winner_id = params[:winner_id]
    @showdown.loser_id = params[:loser_id]
    @showdown.winner_oldrating = params[:winner_oldrating]
    @showdown.winner_newrating = params[:winner_newrating]
    @showdown.loser_oldrating = params[:loser_oldrating]
    @showdown.loser_newrating = params[:loser_newrating]

    save_status = @showdown.save

    if save_status == true
      redirect_to("/showdowns/#{@showdown.id}", :notice => "Showdown updated successfully.")
    else
      render("showdowns/edit.html.erb")
    end
  end

  def destroy
    @showdown = Showdown.find(params[:id])

    @showdown.destroy

    if URI(request.referer).path == "/showdowns/#{@showdown.id}"
      redirect_to("/", :notice => "Showdown deleted.")
    else
      redirect_to(:back, :notice => "Showdown deleted.")
    end
  end
end
