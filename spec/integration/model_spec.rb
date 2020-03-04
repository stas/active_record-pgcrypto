require 'spec_helper'
require 'securerandom'

RSpec.describe User do
  let(:good_user) { User.create!(email: FFaker::Internet.email) }
  let(:bad_user) { User.create!(email: FFaker::Internet.email) }

  it 'finds the searched user' do
    expect(good_user.email).not_to eq(bad_user.email)

    filtered = User.where(
      User.decrypted_email.matches(good_user.email.first(4) + '%')
    )

    expect(filtered.count).to eq(1)
    expect(filtered.first).to eq(good_user)
  end

  it 'stays unchanged' do
    good_user.reload
    expect(good_user).not_to be_changed

    good_user.email = good_user.reload.email
    expect(good_user).not_to be_changed

    good_user.email = FFaker::Internet.email
    expect(good_user).to be_changed

    good_user.reload
    expect(good_user).not_to be_changed
  end
end
