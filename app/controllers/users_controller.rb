 class UsersController < ApplicationController
  #load_and_authorize_resource  #accomplishes the routing to match the user against the role and access but not used in devise/cancan 
  before_action :authenticate_user!, only: :index


  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = current_user
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

end