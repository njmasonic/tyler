require 'spec_helper'

describe SessionsController do
  let(:consumer) { mock_model(Consumer, name: 'lodge00', return_url: 'www.lodge00.net/sso_return') }
  let(:user)     { mock_model(User) }
  let(:token)    { mock_model(Token, token: 'abcd') }

  describe "with a consumer supplied" do
    before do
      Consumer.stub(:find_by_name).with('lodge00').and_return(consumer)
      Token.stub(:find_or_create_by_consumer_id_and_user_id).with(consumer, user).and_return(token)
    end

    describe "GET new", "without an existing session" do
      before do
        controller.stub(:current_user).and_return(nil)
        get :new
      end

      it { should render_template("new") }
    end

    describe "GET new", "with an existing session" do
      before do
        controller.stub(:current_user).and_return(user)
        user.stub(:current_token).and_return(token)
        token.should_receive(:ensure_current!)
        get :new, consumer: 'lodge00'
      end

      it { should redirect_to("www.lodge00.net/sso_return?token=abcd") }
    end

    describe "POST create", "with valid parameters" do
      before do
        controller.stub(:authenticate).with(hash_including('session' => hash_including('email' => 'tom@smith.net', 'password' => '1234'))).and_return(user)
        controller.should_receive(:sign_in).with(user)
        token.should_receive(:ensure_current!)
        post :create, 'session' => { 'email' => 'tom@smith.net', 'password' => '1234', 'consumer' => 'lodge00' }
      end

      it { should redirect_to("www.lodge00.net/sso_return?token=abcd") }
    end
  end

  describe "without a consumer supplied" do
    describe "GET new", "without an existing session" do
      before do
        controller.stub(:current_user).and_return(nil)
        get :new
      end

      it { should render_template("new") }
    end

    describe "GET new", "with an existing session" do
      before do
        controller.stub(:current_user).and_return(user)
        get :new
      end

      it { should redirect_to(user) }
    end

    describe "POST create", "with valid parameters" do
      before do
        controller.stub(:authenticate).with(hash_including('session' => hash_including('email' => 'tom@smith.net', 'password' => '1234'))).and_return(user)
        controller.should_receive(:sign_in).with(user)
        post :create, 'session' => { 'email' => 'tom@smith.net', 'password' => '1234' }
      end

      it { should redirect_to(user) }
    end
  end
end
