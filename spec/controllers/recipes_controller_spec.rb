require 'spec_helper'

describe RecipesController, type: :controller do
  describe '#index' do
    before do
      ContentfulServiceHelper.stub_contentful_get('contentful_recipe_fixture')
    end
    let(:recipes_json) do
      parsed_recipes = []
      Services::Contentful.instance.client.entries.each do |recipe|
        parsed_recipes << JSON.generate(recipe, {})
      end
      parsed_recipes
    end

    it 'returns all recipes found' do
      get :index
      expect(JSON.parse(response.body)).to eq(recipes_json)
    end

  end
  describe '#show' do
    context 'existing ID' do 
      before do
        ContentfulServiceHelper.stub_contentful_get('contentful_recipe_fixture')
      end
      let(:recipe_json) { JSON.generate(Services::Contentful.instance.client.entries.first , {}) }

      it 'returns the corresponding recipe' do
        get :show, params: { id: '437eO3ORCME46i02SeCW46' }
        expect(response.body).to eq(recipe_json)
      end
    end
    context 'non existing ID' do
      before do
        ContentfulServiceHelper.stub_contentful_get('recipe_not_found_fixture')
      end

      it 'returns not found response' do
        get :show, params: { id: 'i_dont_exist' }
        expect(response.body).to_not be_present
        expect(response.status).to eq(404)
      end

    end
  end
end