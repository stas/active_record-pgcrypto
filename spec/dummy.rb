require 'active_record'
require 'logger'

ActiveRecord::Base.logger = Logger.new(STDOUT)
ActiveRecord::Base.logger.level = ENV['LOG_LEVEL'] || Logger::WARN
ActiveRecord::Base.establish_connection(ENV['DATABASE_URL'])

ActiveRecord::Schema.define do
  enable_extension 'pgcrypto'

  create_table :users, force: true do |t|
    t.binary :email
  end
end

# Enable PGCrypto Symmetric encryption support.
ENV['PGCRYPTO_SYM_KEY'] = SecureRandom.hex(10)
require 'active_record/pgcrypto'

class User < ActiveRecord::Base
  serialize(:email, ActiveRecord::PGCrypto::SymmetricCoder)

  def self.decrypted_email
    ActiveRecord::PGCrypto::SymmetricCoder
      .decrypted_arel_text(arel_table[:email])
  end
end
