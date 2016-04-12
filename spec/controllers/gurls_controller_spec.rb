require 'rails_helper'

RSpec.describe GurlsController, type: :controller do
  describe 'GET #new' do
    it 'creates a new Gurl for use in the form'
    it 'renders the :new template'
  end

  describe 'POST #create' do
    context "with valid attributes" do
      it 'saves the new gurl to the database'
      it 'redirects to generate#show'
    end

    context "without valid attributes" do
      it 'does not save the gurl to the database'
      it 're-renders the new form'
    end
  end
end
