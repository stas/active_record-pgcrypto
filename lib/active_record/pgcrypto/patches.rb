require 'active_record/type/serialized'

module ActiveRecord
  # ...
  module PGCrypto
    # Patched `serialize` wrapper class to play well with [ActiveModel::Dirty]
    module PatchedSerialized
      # Determines whether the mutable value has been modified since it was read
      #
      # Since encrypted binary data, from our coder,
      # can return same decrypted values, we don't check it.
      #
      # @return [FalseClass] on our coder values.
      def changed_in_place?(*)
        return false if coder == ActiveRecord::PGCrypto::SymmetricCoder

        super
      end
    end

    ActiveRecord::Type::Serialized.prepend(PatchedSerialized)
  end
end
