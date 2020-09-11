# frozen_string_literal: true

require 'contentful'
require_relative '../../app/models/recipe_model.rb'
require_relative '../../app/models/chef_model.rb'
require_relative '../../app/models/photo_model.rb'
require_relative '../../app/models/tag_model.rb'

module Services
  # This is based on the example provided by Contentful here:
  # https://github.com/contentful/the-example-app.rb/blob/master/services/contentful.rb
  class Contentful
    attr_reader :space_id, :delivery_token, :api_url, :environment_id

    # Gets or creates a Contentful Service Wrapper
    #
    # @return [Services::Contentful]
    def self.instance
      @instance ||= nil

      # We create new client instances only if client wasn't instantiated before
      if @instance.nil?
        @instance = new(
          ENV['CONTENTFUL_SPACE_ID'],
          ENV['CONTENTFUL_DELIVERY_TOKEN'],
          ENV['CONTENTFUL_API_URL'],
          ENV['CONTENTFUL_ENVIRONMENT_ID']
        )
      end

      @instance
    end

    # Creates a Contentful client
    #
    # @param space_id [String]
    # @param access_token [String] Delivery or Preview API access token
    # @param api_url [String] the API URL to fetch data
    # @param environment_id [Number] the environment ID to connect
    #
    # @return [::Contentful::Client]
    def self.create_client(space_id, access_token, api_url, environment_id)
      options = {
        space: space_id,
        access_token: access_token,
        environment: environment_id,
        dynamic_entries: :auto,
        raise_errors: false,
        api_url: api_url,
        entry_mapping: {
          'recipe' => RecipeModel,
          'chef' => ChefModel,
          'tag' => TagModel
        },
        resource_mapping: {
          'Asset' => PhotoModel
        }
      }

      ::Contentful::Client.new(options)
    end

    # Returns the delivery client
    #
    # @return [::Contentful::Client]
    def client
      @delivery_client
    end

    # Returns the current space
    #
    # @param api_id [String]
    #
    # @return [::Contentful::Space]
    def space
      client.space
    end

    # Returns the current available locales
    #
    # @param api_id [String]
    #
    # @return [::Contentful::Array<::Contentful::Locale>]
    def locales
      client.locales
    end

    # Returns an entry by ID
    #
    # @param entry_id [String]
    #
    # @return [::Contentful::Entry]
    def entry(entry_id)
      client.entry(entry_id)
    end

    # Returns a collection of entries by query options
    #
    # @param options [Object]
    #
    # @return [::Contentful::Array]
    def entries(options)
      client.entries(options)
    end

    private

    def initialize(space_id, delivery_token, api_url, environment_id)
      @space_id = space_id
      @delivery_token = delivery_token
      @api_url = api_url
      @environment_id = environment_id

      @delivery_client = self.class.create_client(@space_id, @delivery_token, @api_url, @environment_id)
    end
  end
end
