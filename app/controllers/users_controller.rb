class UsersController < ApplicationController
 before_action :authorize_request, except: :create
 before_action :find_user, except: %i[create index]

  # GET /users
  def index
    if params[:search_name].present?
    @users = User.where("name LIKE ?", "%#{params[:search_name]}%").paginate(page: params[:page])    
    else
    @users = User.paginate(page: params[:page])    
    end
    render json: {user:@users,  meta: pagination_meta(@users)}

  end
  
  def pagination_meta(user)       
    {        
     current_page: user.current_page,        
     next_page: user.next_page,        
     per_page: user.per_page,        
     total_pages: user.total_pages,        
     total_entries: user.total_entries
    }  
  end

  # GET /users/{username}
  def show
    render json: @user, status: :ok
  end

  # POST /users
  def create
    #params.delete(:user)
    @user = User.new(user_params)

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
