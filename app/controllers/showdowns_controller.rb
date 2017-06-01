class ShowdownsController < ApplicationController
  def index
    @showdowns = Showdown.all.reverse

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
    # @winner_id = params[:winner_id].to_f
    @showdown.winner_id = params[:winner_id]
    @showdown.loser_id = params[:loser_id]
    # if :winner_id == :img1
    #   @showdown.loser_id = params[:img2]
    #   @loser_id = params[:img2].to_f
    # else
    #   @showdown.loser_id = params[:img1]
    #   @loser_id = params[:img1].to_f
    # end

    @showdown.winner_oldrating = Photo.find(params[:winner_id]).rating

    @showdown.loser_oldrating = Photo.find(params[:loser_id]).rating
    @winrate = Photo.find(params[:winner_id]).rating.to_f
    @rwinner = 10 ** ( @winrate / 400)
    @loserate = Photo.find(params[:loser_id]).rating.to_f
    @rloser = 10 ** ( @loserate / 400)



    @showdown.winner_newrating = Photo.find(params[:winner_id]).rating + 32*(1-(@rwinner / (@rwinner + @rloser)))
    @showdown.loser_newrating = Photo.find(params[:loser_id]).rating + 32*(0-@rloser / (@rwinner + @rloser))

    save_status = @showdown.save

    if save_status == true
      @photo = Photo.find(params[:winner_id])

      @photo.rating = @showdown.winner_newrating

      save_status = @photo.save

      if save_status == true
        @photob = Photo.find(params[:loser_id])

        @photob.rating = @showdown.loser_newrating

        save_status = @photob.save

        if save_status == true
                redirect_to("/showdowns/new", :notice => "Showdown created successfully.")
        else
          render("showdowns/new.html.erb")
        end

      else
        render("showdowns/new.html.erb")
      end

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
