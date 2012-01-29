require 'spec_helper'

describe UsersController do
  let(:registration_properties) { ["code", "last_name", "zip_code"] }

  before { APP_CONFIG["registration_properties"] = registration_properties }

  describe "when signed out" do
    describe "GET new" do
      before { get :new }

      it { should respond_with(:success) }
      it { should render_template(:new) }
      it { should_not set_the_flash }
      it { should assign_to(:registration_properties).with(registration_properties) }
    end
  end
end
