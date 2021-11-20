class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show]


  def show
    add_breadcrumb "Profile"
    add_breadcrumb @user.email
  end


private

  def set_user
    @user = User.find(params[:id]) if params[:id]
  end

  def user_params
    params.require(:user).permit(
      :id,
      :firstname,
      :lastname,
      :email,
      :reset_password_token,
      :policy_rule_cookie,
      :password,
      :password_confirmation,
      :avatar,
      :role_ids => [],
    )
  end

end
