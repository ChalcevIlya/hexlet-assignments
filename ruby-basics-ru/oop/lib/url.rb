# frozen_string_literal: true

require 'uri'
require 'forwardable'

# BEGIN
class Url
  extend Forwardable
  include Comparable

  attr_accessor :uri, :params

  def initialize(url_text)
    @uri = URI(url_text)
    @params = {}
    @uri_no_query = uri.to_s.sub(uri.query, '')
    parse_query
  end

  def_delegators :@uri, :scheme, :host, :port

  def query_params
    params
  end

  def query_param(key, default = nil)
    params.include?(key.to_sym) ? params[key.to_sym] : default
  end

  def ==(other)
    if params.any? && other.params.any?
      uri_no_query == other.uri_no_query && params == other.params
    else
      uri.to_s == other.uri.to_s
    end
  end

  private

  def parse_query
    return if uri.query.nil?

    separators = ['&', '=']
    temp_array = uri.query.split(Regexp.union(separators))
    i = 0
    while i < temp_array.size
      params[temp_array[i].to_sym] = temp_array[i + 1]
      i += 2
    end
  end
end
# END
