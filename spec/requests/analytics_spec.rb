 require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to test the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator. If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails. There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.

RSpec.describe "/analytics", type: :request do
  # Analytic. As you add validations to Analytic, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
  }

  describe "GET /index" do
    it "renders a successful response" do
      Analytic.create! valid_attributes
      get analytics_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      analytic = Analytic.create! valid_attributes
      get analytic_url(analytic)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_analytic_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      analytic = Analytic.create! valid_attributes
      get edit_analytic_url(analytic)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Analytic" do
        expect {
          post analytics_url, params: { analytic: valid_attributes }
        }.to change(Analytic, :count).by(1)
      end

      it "redirects to the created analytic" do
        post analytics_url, params: { analytic: valid_attributes }
        expect(response).to redirect_to(analytic_url(Analytic.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Analytic" do
        expect {
          post analytics_url, params: { analytic: invalid_attributes }
        }.to change(Analytic, :count).by(0)
      end

      it "renders a successful response (i.e. to display the 'new' template)" do
        post analytics_url, params: { analytic: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested analytic" do
        analytic = Analytic.create! valid_attributes
        patch analytic_url(analytic), params: { analytic: new_attributes }
        analytic.reload
        skip("Add assertions for updated state")
      end

      it "redirects to the analytic" do
        analytic = Analytic.create! valid_attributes
        patch analytic_url(analytic), params: { analytic: new_attributes }
        analytic.reload
        expect(response).to redirect_to(analytic_url(analytic))
      end
    end

    context "with invalid parameters" do
      it "renders a successful response (i.e. to display the 'edit' template)" do
        analytic = Analytic.create! valid_attributes
        patch analytic_url(analytic), params: { analytic: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested analytic" do
      analytic = Analytic.create! valid_attributes
      expect {
        delete analytic_url(analytic)
      }.to change(Analytic, :count).by(-1)
    end

    it "redirects to the analytics list" do
      analytic = Analytic.create! valid_attributes
      delete analytic_url(analytic)
      expect(response).to redirect_to(analytics_url)
    end
  end
end
