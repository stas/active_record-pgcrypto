require 'active_support'
require 'active_record/log_subscriber'
require 'active_record/pgcrypto/version'
require 'active_record/pgcrypto/patches'
require 'active_record/pgcrypto/symmetric_coder'
require 'active_record/pgcrypto/log_subscriber'

module ActiveRecord
  # PostgreSQL PGCrypto support for [ActiveRecord]
  module PGCrypto
    # Enables the log scrubber
    #
    # @return [NilClass]
    def self.enable_log_subscriber!
      ::ActiveRecord::LogSubscriber.prepend(LogSubscriber)
    end
  end
end
