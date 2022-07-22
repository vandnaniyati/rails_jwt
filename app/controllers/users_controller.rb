class UsersController < ApplicationController
 before_action :authorize_request, except: :create
 before_action :find_user, except: %i[create index]

  # GET /users
  def index
    @users = User.all
    # data = {
    #   @user.map do |user|
    #     {email:user.email, name: @user.name, username: user.username}
    #   end
    # }
    render json: @users, status: :ok
  end

  # GET /users/{username}
  def show
    render json: @user, status: :ok
  end

  # POST /users
  def create
    #params.delete(:user)
    @user = User.new(user_params)

    #data = {email: @user.email, name: @user.name, username: @user.username}
    if @user.save
      render json: @user, status: :created
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # PUT /users/{username}
  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: { errors: @user.errors.full_messages },
             status: :unprocessable_entity
    end
  end

  # DELETE /users/{username}
  def destroy
    @user.destroy
  end

  private

  def find_user
    @user = User.find_by_username!(params[:_username])
    rescue ActiveRecord::RecordNotFound
      render json: { errors: 'User not found' }, status: :not_found
  end

  def user_params
    params.permit(
       :name, :username, :email, :password, :password_confirmation
    )
  end
end
