# frozen_string_literal: true

require 'spec_helper'
require_relative '../../app/models/photo_model.rb'
require_relative '../../lib/services/contentful.rb'
require_relative '../helpers/contentful_service_helper.rb'

RSpec.describe 'Chef model' do
  before do
    ContentfulServiceHelper.stub_contentful_get('contentful_recipe_fixture')
  end

  context 'with full properties' do
    let(:recipe) { Services::Contentful.instance.client.entries.first }

    it 'contains name' do
      expect(recipe.fields[:chef].name).to eq('Jony Chives')
    end
  end
end
