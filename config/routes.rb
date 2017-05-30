Rails.application.routes.draw do
  # Routes for the Showdown resource:
  # CREATE
  get "/showdowns/new", :controller => "showdowns", :action => "new"
  post "/create_showdown", :controller => "showdowns", :action => "create"

  # READ
  get "/showdowns", :controller => "showdowns", :action => "index"
  get "/showdowns/:id", :controller => "showdowns", :action => "show"

  # UPDATE
  get "/showdowns/:id/edit", :controller => "showdowns", :action => "edit"
  post "/update_showdown/:id", :controller => "showdowns", :action => "update"

  # DELETE
  get "/delete_showdown/:id", :controller => "showdowns", :action => "destroy"
  #------------------------------

  devise_for :users
  # Routes for the Photo resource:
  # CREATE
  get "/photos/new", :controller => "photos", :action => "new"
  post "/create_photo", :controller => "photos", :action => "create"

  # READ
  get "/photos", :controller => "photos", :action => "index"
  get "/photos/:id", :controller => "photos", :action => "show"

  # UPDATE
  get "/photos/:id/edit", :controller => "photos", :action => "edit"
  post "/update_photo/:id", :controller => "photos", :action => "update"

  # DELETE
  get "/delete_photo/:id", :controller => "photos", :action => "destroy"
  #------------------------------
  root to: "photos#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
