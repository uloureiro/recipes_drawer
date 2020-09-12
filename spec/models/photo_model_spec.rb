# frozen_string_literal: true

require 'spec_helper'
require_relative '../../app/models/photo_model.rb'
require_relative '../../lib/services/contentful.rb'
require_relative '../helpers/contentful_service_helper.rb'

RSpec.describe 'Photo model' do
  before do
    ContentfulServiceHelper.stub_contentful_get('contentful_recipe_fixture')
  end

  context 'with full properties' do
    let(:recipes) { Services::Contentful.instance.client.entries }

    it 'contains URL' do
      expect(recipes.first.fields[:photo].url).to eq('//images.ctfassets.net/th141s4f4k32p4c3/5mFyTozvSoyE0Mqseoos86/fb88f4302cfd184492e548cde11a2555/SKU1479_Hero_077-71d8a07ff8e79abcb0e6c0ebf0f3b69c.jpg')
    end
    it 'contains name' do
      expect(recipes.first.fields[:photo].name).to eq('SKU1479_Hero_077-71d8a07ff8e79abcb0e6c0ebf0f3b69c.jpg')
    end
    it 'contains content type' do
      expect(recipes.first.fields[:photo].content_type).to eq('image/jpeg')
    end
  end
end
