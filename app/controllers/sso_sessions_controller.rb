class SsoSessionsController < Clearance::SessionsController
  def new
    if current_user
      consumer = Consumer.find_by_name(params[:consumer])
      raise "Invalid or no consumer provided." if consumer.nil?
      redirect_to_consumer_with_token(consumer, current_user.current_token)
    else
      render 'new'
    end
  end

  def create
    consumer = Consumer.find_by_name(params[:session][:consumer])
    raise "Invalid or no consumer provided." if consumer.nil?
    @user = authenticate(params)
    if @user.nil?
      flash_failure_after_create
      render 'new', :status => :unauthorized
    else
      token = Token.create! user: @user
      sign_in(@user)
      redirect_to_consumer_with_token(consumer, token)
    end
  end

  private

  def redirect_to_consumer_with_token(consumer, token)
    token.ensure_current!
    redirect_to "#{consumer.return_url}?token=#{token.token}"
  end
end
