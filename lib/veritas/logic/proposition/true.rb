module Veritas
  module Logic
    class Proposition
      class True < Proposition
        def self.inverse
          False
        end

        def self.call
          true
        end

        def and(other)
          other
        end

        def or(other)
          self
        end

      end # class True
    end # class Proposition
  end # module Algebra
end # module Veritas
