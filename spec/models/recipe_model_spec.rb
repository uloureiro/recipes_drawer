# frozen_string_literal: true

require 'spec_helper'
require_relative '../../app/models/photo_model.rb'
require_relative '../../lib/services/contentful.rb'
require_relative '../helpers/contentful_service_helper.rb'

RSpec.describe 'Recipe model' do
  context 'with full properties' do
    before do
      ContentfulServiceHelper.stub_contentful_get('contentful_recipe_fixture')
    end

    let(:recipe) { Services::Contentful.instance.client.entries.first }
    let(:expected_recipe) do
      {
        id: '437eO3ORCME46i02SeCW46',
        title: 'Crispy Chicken and Rice with Peas & Arugula Salad',
        photo: '//images.ctfassets.net/th141s4f4k32p4c3/5mFyTozvSoyE0Mqseoos86/fb88f4302cfd184492e548cde11a2555/SKU1479_Hero_077-71d8a07ff8e79abcb0e6c0ebf0f3b69c.jpg',
        tags: ['gluten free', 'healthy'],
        description: 'Crispy chicken skin, tender meat, and rich, tomatoey sauce form a winning trifecta of delicious in this one-pot braise. We spoon it over rice and peas to soak up every last drop of goodness, and serve a tangy arugula salad alongside for a vibrant boost of flavor and color. Dinner is served! Cook, relax, and enjoy!',
        chef: 'Jony Chives',
      }
    end

    it 'has title' do
      expect(recipe.title).to eq(expected_recipe[:title])
    end
    it 'has photo URL' do
      expect(recipe.photo).to eq(expected_recipe[:photo])
    end
    it 'has multiple tags' do
      expect(recipe.tags).to eq(expected_recipe[:tags])
    end

    it 'has description' do
      expect(recipe.description).to eq(expected_recipe[:description])
    end

    it 'has chef name' do
      expect(recipe.chef).to eq(expected_recipe[:chef])
    end

    it 'create a hash with corresponding values' do
      result = recipe.to_h
      expect(result[:title]).to eq(expected_recipe[:title])
      expect(result[:photo]).to eq(expected_recipe[:photo])
      expect(result[:tags]).to eq(expected_recipe[:tags])
      expect(result[:description]).to eq(expected_recipe[:description])
      expect(result[:chef]).to eq(expected_recipe[:chef])
    end

    it 'creates a json with corresponding values' do
      expect(recipe.to_json).to eq(JSON.generate(expected_recipe, {}))
    end
  end

  context 'weird empty recipe' do
    before do
      ContentfulServiceHelper.stub_contentful_get('contentful_weird_empty_recipe_fixture')
    end

    let(:recipe) { Services::Contentful.instance.client.entries.first }
    let(:expected_recipe) do
      {
        id: '437eO3ORCME46i02SeCW46',
        title: nil,
        photo: nil,
        tags: nil,
        description: nil,
        chef: nil,
      }
    end

    it 'does not have title' do end
    it 'does not have photo' do end
    it 'does not have tags' do end
    it 'does not have chef' do end
    it 'creates an empty hash' do
      result = recipe.to_h
      expect(result[:title]).to eq(expected_recipe[:title])
      expect(result[:photo]).to eq(expected_recipe[:photo])
      expect(result[:tags]).to eq(expected_recipe[:tags])
      expect(result[:description]).to eq(expected_recipe[:description])
      expect(result[:chef]).to eq(expected_recipe[:chef])
    end
    it 'creates an empty json' do
      expect(recipe.to_json).to eq(JSON.generate(expected_recipe, {}))
    end
  end
end
