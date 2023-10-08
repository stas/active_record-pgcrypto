require 'spec_helper'
require 'active_record/pgcrypto/log_subscriber'

RSpec.describe ActiveRecord::PGCrypto::LogSubscriber do
  let(:pgcrypto_key) { FFaker::Internet.password }
  let(:subscriber) { ActiveRecord::LogSubscriber.new }
  let(:event_payload) do
    { sql: "SELECT PGP_SYM_ENCRYPT_BYTEA('data', '#{pgcrypto_key}')" }
  end
  let(:event) do
    ActiveSupport::Notifications::Event.new(:test, 0, 0, :id, event_payload)
  end

  before do
    ActiveRecord::PGCrypto.enable_log_subscriber!
  end

  it do
    subscriber.sql(event)

    expect(event.payload[:sql]).not_to include(pgcrypto_key)
    expect(event.payload[:sql]).to include(described_class::PLACEHOLDER)
  end
end
