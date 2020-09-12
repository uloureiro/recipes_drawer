require 'spec_helper'
require 'multi_json'

class ContentfulServiceHelper
  RESPONSE_HEADERS = {
    'Connection' => 'keep-alive',
    'Content-Length' => '1295',
    'Access-Control-Allow-Headers' => 'Accept,Accept-Language,Authorization,Cache-Control,Content-Length,Content-Range,Content-Type,DNT,Destination,Expires,If-Match,If-Modified-Since,If-None-Match,Keep-Alive,Last-Modified,Origin,Pragma,Range,User-Agent,X-Http-Method-Override,X-Mx-ReqToken,X-Requested-With,X-Contentful-Version,X-Contentful-Content-Type,X-Contentful-Organization,X-Contentful-Skip-Transformation,X-Contentful-User-Agent,X-Contentful-Enable-Alpha-Feature',
    'Access-Control-Allow-Methods' => 'GET,HEAD,OPTIONS',
    'Access-Control-Allow-Origin' => '*',
    'Access-Control-Expose-Headers' => 'Etag',
    'Access-Control-Max-Age' => '86400',
    'cf-environment-id' => 'master',
    'cf-environment-uuid' => '12345678-d2b3-1234-a2b3-ed1215cbd839',
    'cf-organization-id' => 'th12124f4k30RG4n1z4t10n',
    'cf-space-id' => 'f4k32p4c3',
    'Content-Type' => 'application/vnd.contentful.delivery.v1+json',
    'Contentful-Api' => 'cda_cached',
    'etag' => 'W/"10092403212672983250"',
    'Server' => 'Contentful',
    'X-Content-Type-Options' => 'nosniff',
    'X-Contentful-Region' => 'us-east-1',
    'x-contentful-route' => '/spaces/:space/environments/:environment/entries',
    'Accept-Ranges' => 'bytes',
    'Date' => 'Sun, 13 Sep 2020 00:13:20 GMT',
    'Via' => '1.1 varnish',
    'Age' => '0',
    'X-Served-By' => 'cache-gru17139-GRU',
    'X-Cache' => 'MISS',
    'X-Cache-Hits' => '0',
    'Vary' => 'Accept-Encoding',
    'x-contentful-request-id' => 'c4babc5c-5413-46f4-9b30-5dfd01dbcc29'
  }.freeze

  class << self
    def stub_contentful_get(fixture)
      WebMock.stub_request(:get, /\/environments\/master\/content_types/)
             .to_return(status: 200, body: json_fixture('content_types_fixture'), headers: {})

      WebMock.stub_request(:get, /\/environments\/master\/entries/)
             .to_return(body: json_fixture(fixture), status: 200, headers: RESPONSE_HEADERS)
    end

    private

    # thanks to https://github.com/contentful/contentful.rb/blob/master/spec/support/json_responses.rb
    def json_fixture(which)
      File.read File.dirname(__FILE__) + "/../fixtures/files/#{which}.json"
    end
  end
end
