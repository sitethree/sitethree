require "sitethree/version"
require 'net/http'
require 'uri'
require 'cgi'
require 'nokogiri'

module Sitethree
  API_URL         = 'http://xml.sitethree.com/'
  class Search

    class << self
      attr_accessor :publisher_id, :feed_id, :source, :user_ip, :user_agent, :keywords, :errors
    end


    def initialize(options = {})
      self.class.publisher_id = options[:publisher_id]
      self.class.feed_id = options[:feed_id]
    end

    def get_ads(params = {})
      ads = []
      url = "#{API_URL}?partner_id=#{self.class.publisher_id}&feed_id=#{self.class.feed_id}&source=#{CGI::escape(params[:source])}&user_ip=#{params[:user_ip]}&user_agent=#{CGI::escape(params[:user_agent])}&keywords=#{CGI::escape(params[:keywords])}#{params[:testapi] ? "&test=testapi" : ""}"
      uri = URI.parse(url)
      response = Net::HTTP.get_response(uri)
      doc = Nokogiri::XML.parse(response.body)
      response = doc.xpath("/response").first
      if response.attr("valid_request") == "true" && response.attr("num_results") != '0'
        doc.xpath("//ad").each do |ad|
          ads << {'title' => ad.attr("title"), 'description' => ad.attr("description"), 'display_url' => ad.attr("display_url"), 'click_url' => ad.text.strip}
        end
      else
        Rails.logger.info url
      end
      ads
    end
  end
end
