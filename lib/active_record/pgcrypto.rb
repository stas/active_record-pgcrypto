require 'active_record/pgcrypto/version'
require 'active_record/log_subscriber'
require 'active_record/pgcrypto/symmetric_coder'

module ActiveRecord
  # PostgreSQL PGCrypto support for [ActiveRecord]
  module PGCrypto
    # Enables the log scrubber
    #
    # @return [NilClass]
    def self.enable_log_subscriber!
      ActiveRecord::LogSubscriber.prepend(ActiveRecord::PGCrypto::LogSubscriber)
    end
  end
end
