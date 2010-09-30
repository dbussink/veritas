module Veritas
  module Logic
    class Predicate

      # A predicate representing an inequality test between operands
      class Inequality < Predicate
        include Comparable

        # Return the Inequality operation
        #
        # @example
        #   Inequality.operation  # => :!=
        #
        # @return [Symbol]
        #
        # @api public
        def self.operation
          :'!='
        end

        # Return the inverse predicate class
        #
        # @example
        #   Inequality.inverse  # => Equality
        #
        # @return [Equality]
        #
        # @api public
        def self.inverse
          Equality
        end

        # Return the reverse predicate class
        #
        # @example
        #   Inequality.reverse  # => Inequality
        #
        # @return [self]
        #
        # @api public
        def self.reverse
          self
        end

        # Evaluate the values for inequality
        #
        # @example
        #   Inequality.call(left, right)  # => true or false
        #
        # @param [Object] left
        # @param [Object] right
        #
        # @return [Boolean]
        #
        # @api public
        def self.call(left, right)
          left != right
        end unless Object.method_defined?(operation)

        module Methods

          # Compare the expressions for Inequality
          #
          # @example
          #   inequality = expression.eq(other)
          #
          # @param [Expression] other
          #
          # @return [Inequality]
          #
          # @api public
          def ne(other)
            Inequality.new(self, other)
          end

        end # module Methods
      end # class Inequality
    end # class Predicate
  end # module Algebra
end # module Veritas
