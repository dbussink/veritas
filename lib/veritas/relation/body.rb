require 'set'

module Veritas
  class Relation
    class Body
      include Enumerable

      attr_reader :header

      def initialize(header, tuples = Set.new)
        @header, @tuples = header, tuples.to_set
      end

      def each(&block)
        to_set.each(&block)
        self
      end

      def intersect(other)
        new(to_set & other)
      end

      alias & intersect

      def union(other)
        new(to_set | other)
      end

      alias | union

      def difference(other)
        new(to_set - other)
      end

      alias - difference

      def to_set
        @tuples
      end

      def ==(other)
        other = coerce(other)
        header == other.header &&
        to_set == other.to_set
      end

      def eql?(other)
        instance_of?(other.class) &&
        header.eql?(other.header) &&
        to_set.eql?(other.to_set)
      end

    private

      def new(tuples)
        self.class.new(header, tuples)
      end

      def coerce(other)
        kind_of?(other.class) ? other : new(other)
      end
    end
  end
end