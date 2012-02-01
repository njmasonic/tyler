class RegistrationsController < ApplicationController
  def new
    @registration = Registration.new
  end

  def create
    @registration = Registration.new(params[:registration])
    if @registration.save
      sign_in @registration.user
      redirect_to @registration.user
    else
      render "new"
    end
  end
end
