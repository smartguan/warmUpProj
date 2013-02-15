class UsersController < ApplicationController
  def get_current_user
    @user = Users.new(:name => params[:user], :password => params[:password], :count=>1) 
  end
  
  def add
    get_current_user

    respond_to do |format|
      if not Users.exists?(:name => @user.name)
        if @user.name == "" or @user.name.size > 128
          format.json {render json: {errCode: -3, count: @user.count}}
        elsif @user.password.size > 128
          format.json {render json: {errCode: -4, count: @user.count}}
        else
          @user.save
          format.json {render json: {errCode: 1, count: @user.count}}
        end
      else
        format.json {render json: {errCode: -2, count: @user.count}}
      end
    end
  end

  def login
    get_current_user
    user_login = Users.where(:name => @user.name, :password => @user.password).first 
    respond_to do |format|
      if user_login == nil
        format.json {render json: {errCode: -1}}
      else
        user_login.count += 1
        user_login.save
        format.json {render json: {errCode: 1, count: user_login.count}}
      end
    end
  end
end
