require 'spec_helper'
require 'securerandom'

RSpec.describe User do
  let(:good_user) { User.create!(email: FFaker::Internet.email) }
  let(:bad_user) { User.create!(email: FFaker::Internet.email) }

  it 'finds the searched user' do
    expect(good_user.email).not_to eq(bad_user.email)

    filtered = User.where(User.decrypted_email.eq(good_user.email))
    expect(filtered.count).to eq(1)
    expect(filtered.first).to eq(good_user)
  end
end
