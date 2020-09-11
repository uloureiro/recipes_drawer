# frozen_string_literal: true

require_relative '../../lib/services/contentful.rb'

# Provide API interfaces to interact to Recipes
class RecipesController < ApplicationController
  RECIPE_DEFAULT_LIMIT = 5
  RECIPE_DEFAULT_OPTIONS = {
    content_type: 'recipe',
    locale: 'en-US',
    limit: RECIPE_DEFAULT_LIMIT
  }.freeze

  def index
    options = RECIPE_DEFAULT_OPTIONS.merge(
      {
        skip: params[:page].presence.to_i * RECIPE_DEFAULT_LIMIT
      }
    )
    @recipes = Services::Contentful.instance.client.entries(options)
    parsed_recipes = []
    @recipes.each do |recipe|
      parsed_recipes << recipe.to_json
    end
    render body: parsed_recipes
  end

  def show
    @recipe = Services::Contentful.instance.entry(params[:id])
    render body: @recipe.to_json if @recipe.present?
    render body: nil, status: :not_found unless @recipe.present?
  end
end
