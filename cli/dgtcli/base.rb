module Dgtcli
  class Base < ActiveResource::Base
    def self.config
      @config ||= ENV['TEST_APP']
    end

    self.site   = config
    self.format = :json
  end
end

