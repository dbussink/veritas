# encoding: utf-8

module Veritas
  class Aggregate

    # The sum of a sequence of numbers
    class Sum < Aggregate

      DEFAULT = 0

      # Return the sum for a sequence of numbers
      #
      # @example
      #   sum = Sum.call(sum, value)
      #
      # @param [Numeric] sum
      #
      # @param [Object] value
      #
      # @return [Numeric]
      #
      # @api public
      def self.call(sum, value)
        sum + value
      end

      # Return the default sum
      #
      # @return [Numeric]
      #
      # @todo refactor once functions know their return types
      #
      # @api public
      def default
        default = super
          case operand
          when Attribute::Float   then default.to_f
          when Attribute::Decimal then BigDecimal(default.to_s)
          else
            default
        end
      end

      module Methods

        # Return a sum aggregate function
        #
        # @example
        #   sum = attribute.sum
        #
        # @param [Attribute]
        #
        # @return [Sum]
        #
        # @api public
        def sum
          Sum.new(self)
        end

      end # module Methods
    end # class Sum
  end # class Aggregate
end # module Veritas
