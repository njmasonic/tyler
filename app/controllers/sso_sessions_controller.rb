class SsoSessionsController < Clearance::SessionsController
  def new
    if current_user
      consumer = Consumer.find_by_name(params[:consumer])
      raise "Invalid or no consumer provided." if consumer.nil?
      redirect_to_consumer(consumer, current_user)
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
      sign_in(@user)
      redirect_to_consumer(consumer, @user)
    end
  end

  private

  def fetch_token(consumer, user)
    Token.find_or_create_by_consumer_id_and_user_id(consumer, user)
  end

  def redirect_to_consumer(consumer, user)
    token = fetch_token(consumer, user)
    token.ensure_current!
    redirect_to "#{consumer.return_url}?token=#{token.token}"
  end
end
