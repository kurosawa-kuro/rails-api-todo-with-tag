require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  let!(:tag) { create(:tag) }

  describe "GET #index" do
    it "returns a success response" do
      get :index
      expect(response).to be_successful
      json_response = JSON.parse(response.body)
      expect(json_response.first["id"]).to eq(tag.id)
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      get :show, params: { id: tag.id }
      expect(response).to be_successful
      json_response = JSON.parse(response.body)
      expect(json_response["id"]).to eq(tag.id)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_attributes) { { name: 'New Tag' } }

      it "creates a new Tag" do
        expect {
          post :create, params: { tag: valid_attributes }
        }.to change(Tag, :count).by(1)
      end

      it "renders a JSON response with the new tag" do
        post :create, params: { tag: valid_attributes }

        puts JSON.pretty_generate(JSON.parse(response.body))

        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { name: nil } }

      it "does not create a new Tag" do
        expect {
          post :create, params: { tag: invalid_attributes }
        }.to_not change(Tag, :count)
      end

      it "renders a JSON response with errors for the new tag" do
        post :create, params: { tag: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH #update" do
    context "with valid parameters" do
      let(:new_attributes) { { name: 'Updated Tag' } }

      it "updates the requested tag" do
        patch :update, params: { id: tag.id, tag: new_attributes }
        tag.reload
        expect(tag.name).to eq('Updated Tag')
      end

      it "renders a JSON response with the tag" do
        patch :update, params: { id: tag.id, tag: new_attributes }
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      let(:invalid_attributes) { { name: nil } }

      it "renders a JSON response with errors for the tag" do
        patch :update, params: { id: tag.id, tag: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested tag" do
      expect {
        delete :destroy, params: { id: tag.id }
      }.to change(Tag, :count).by(-1)
    end
  end
end
