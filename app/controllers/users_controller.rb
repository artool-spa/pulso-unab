class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy, :clients]

  # GET /users
  # GET /users.json
  def index
    @users = User.all.order(email: :asc)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
    @clients = Client.all.order(name: :asc).pluck(:name, :id)
  end

  # GET /users/1/edit
  def edit
    @clients = Client.all.order(name: :asc).pluck(:name, :id)
    @selected_clients = @user.clients.ids
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    unless user_params[:client_ids].blank?
      @user.clients.destroy_all
      @user.clients << Client.find(user_params[:client_ids])
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to users_url, notice: "Usuario '#{@user.email}' creado." }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if user_params[:password].blank?
      user_params.delete(:password)
      user_params.delete(:password_confirmation)
      successfully_updated = @user.update_without_password(user_params)
    else
      successfully_updated = @user.update(user_params)
    end

    unless user_params[:client_ids].blank?
      @user.clients.destroy_all
      @user.clients << Client.find(user_params[:client_ids])
    end

    respond_to do |format|
      if successfully_updated
        format.html { redirect_to users_url, notice: "Usuario '#{@user.email}' modificado." }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    user = @user
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: "Usuario '#{user.email}' eliminado." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation, :is_enabled, :is_admin, :client_ids => [])
    end
end
