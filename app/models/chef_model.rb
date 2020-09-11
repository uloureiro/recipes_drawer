# frozen_string_literal: true

require 'contentful'

# Provide wrapper methods for Chef entries
class ChefModel < Contentful::Entry
  def name
    fields[:name].presence.to_s.squish
  end
end
