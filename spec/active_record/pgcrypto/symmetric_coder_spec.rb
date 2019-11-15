require 'spec_helper'
require 'active_record/pgcrypto/symmetric_coder'

RSpec.describe ActiveRecord::PGCrypto::SymmetricCoder do
  let(:pgcrypto_key) { FFaker::Internet.password }
  let(:text) { '€n©őđ3Đ' }
  let(:numeric) { rand(1.0..5.0) }

  before do
    described_class.pgcrypto_key = pgcrypto_key
  end

  it { expect(described_class.pgcrypto_key).to eq(pgcrypto_key) }

  context 'with encrypted text' do
    it { expect(described_class.dump(text)).not_to eq(text) }

    it { expect(described_class.dump(text)).not_to be_blank }

    it do
      expect(described_class.load(described_class.dump(text))).to eq(text)
    end
  end

  context 'with encrypted numeric' do
    it { expect(described_class.dump(numeric)).not_to eq(numeric.to_s) }

    it { expect(described_class.dump(numeric)).not_to be_blank }

    it do
      expect(
        described_class.load(described_class.dump(numeric))
      ).to eq(numeric.to_s)
    end
  end
end
