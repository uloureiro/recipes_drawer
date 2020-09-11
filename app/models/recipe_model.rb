# frozen_string_literal: true

require 'contentful'
require 'json'

# Provide wrapper methods for Recipe entries
class RecipeModel < Contentful::Entry
  def title
    fields[:title].to_s.squish if fields[:title].present?
  end

  def photo
    fields[:photo].url if fields[:photo].present?
  end

  def tags
    tags_array = []
    if fields[:tags].present?
      fields[:tags].each do |tag|
        tags_array << tag.name
      end
    end

    tags_array unless tags_array.empty?
  end

  def description
    fields[:description].to_s.squish if fields[:description].present?
  end

  def chef
    fields[:chef].name if fields[:chef].present?
  end

  def to_h
    {
      id: id,
      title: title,
      photo: photo,
      tags: tags,
      description: description,
      chef: chef
    }
  end

  def to_json(state = {})
    JSON.generate(to_h, state)
  end
end
