class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(
      email: params[:user][:email].to_s.downcase,
      password: params[:user][:password],
      password_confirmation: params[:user][:password_confirmation]
    )
    if @user.save
      session[:user_id] = @user.id
      redirect_to home_path, notice: "アカウントを作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end
end
