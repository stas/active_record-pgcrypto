module ActiveRecord
  module PGCrypto
    # PGCrypto symmetric encryption/decryption coder for attribute serialization
    module SymmetricCoder
      mattr_accessor :pgcrypto_key do
        ENV['PGCRYPTO_SYM_KEY']
      end
      mattr_accessor :pgcrypto_options do
        ENV['PGCRYPTO_SYM_OPTIONS'] || 'cipher-algo=aes256, unicode-mode=1'
      end
      mattr_accessor :pgcrypto_encoding do
        Encoding.find(ENV['PGCRYPTO_ENCODING'] || 'utf-8')
      end

      # Decrypts the requested value
      #
      # @return [String]
      def self.load(value)
        decrypt(value)
      end

      # Encrypts the requested value
      #
      # @return [String] binary data
      def self.dump(value)
        encrypt(value)
      end

      # Wraps the value into an [Arel::Node] with SQL calls for encryption
      #
      # @return [Arel::Node]
      def self.encrypt(value)
        return value if value.nil?

        encrypted = Arel::Nodes::NamedFunction.new(
          'PGP_SYM_ENCRYPT_BYTEA', [
            Arel::Nodes::Quoted.new(value.to_s),
            Arel::Nodes::Quoted.new(pgcrypto_key),
            Arel::Nodes::Quoted.new(pgcrypto_options)
          ]
        )

        enc_val = arel_query(encrypted)
        ActiveRecord::Base.connection.unescape_bytea(enc_val)
      end

      # Wraps a node for decryption calls
      #
      # @return [Arel::Node]
      def self.decrypted_arel(node)
        Arel::Nodes::NamedFunction.new(
          'PGP_SYM_DECRYPT_BYTEA', [
            node, Arel::Nodes::Quoted.new(pgcrypto_key)
          ]
        )
      end

      # Wraps a node for decryption and text encoded calls
      #
      # @return [Arel::Node]
      def self.decrypted_arel_text(node)
        Arel::Nodes::NamedFunction.new(
          'ENCODE', [
            decrypted_arel(node),
            Arel::Nodes::Quoted.new('escape')
          ]
        )
      end

      # Wraps the value into an [Arel::Node] with SQL calls for decryption
      #
      # @return [Arel::Node]
      def self.decrypt(value)
        return value if value.nil?

        value = ActiveRecord::Base.connection.escape_bytea(value)
        dec_value = arel_query(decrypted_arel(Arel::Nodes::Quoted.new(value)))
        dec_value = ActiveRecord::Base.connection.unescape_bytea(dec_value)
        dec_value.force_encoding(pgcrypto_encoding)
      end

      # Executes the [Arel::Node] generated query
      #
      # @return [String] the first returned value
      def self.arel_query(arel_nodes)
        sel_manager = Arel::SelectManager.new(nil)

        if ::ActiveRecord::VERSION::MAJOR == 4
          sel_manager = Arel::SelectManager.new(::ActiveRecord::Base)
        end

        query = sel_manager.project(arel_nodes).to_sql
        ::ActiveRecord::Base.connection.select_value(query)
      end

      private_class_method :encrypt, :decrypt, :arel_query
    end
  end
end
