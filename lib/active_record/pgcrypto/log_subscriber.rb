module ActiveRecord
  module PGCrypto
    # Subscribes to the logger and obfuscates the sensitive queries.
    module LogSubscriber
      # rubocop:disable Lint/MixedRegexpCaptureTypes
      REGEXP = \
        /(\(*)(?<operation>pgp_sym_(decrypt|encrypt)_bytea)(\(+.*\)+)/im.freeze
      # rubocop:enable Lint/MixedRegexpCaptureTypes
      PLACEHOLDER = '[FILTERED]'.freeze

      # Scrubs the log event from any sensitive SQL
      #
      # @return [NilClass]
      def sql(event)
        scrubbed_sql = event.payload[:sql].gsub(REGEXP) do |_|
          "#{$LAST_MATCH_INFO[:operation]}(#{PLACEHOLDER})"
        end

        event.payload[:sql] = scrubbed_sql

        super(event)
      end
    end
  end
end
