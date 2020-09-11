# frozen_string_literal: true

require 'contentful'

# Provide wrapper methods for Photo asset
class PhotoModel < Contentful::Asset
  def url
    image_url
  end

  def name
    file.file_name
  end

  def content_type
    file.content_type
  end
end
