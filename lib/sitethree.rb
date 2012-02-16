require "sitethree/version"
require "httparty"

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
      response = HTTParty.get(API_URL, :query => {:partner_id => self.class.publisher_id, :feed_id => self.class.feed_id, :source => params[:source], :user_agent => params[:user_agent], :user_ip => params[:user_ip], :keywords => params[:keywords]})
      if response['response']['valid_request'] == 'false'
        self.class.errors = response['response']['error']
        return []
      else
        ads = []
        response['response']['ads']['ad'].each do |ad|
          ads << {:title => ad['title'], :description => ad['description'], :display_url => ad['display_url'], :click_url => ad['click_url']}
        end
        return ads
      end
    end
  end
end
