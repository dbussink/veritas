require File.expand_path('../../../../../../spec_helper', __FILE__)

describe 'Veritas::Algebra::Product.new' do
  before do
    @header = [ [ :id, Integer ] ]

    @left = Relation.new(@header, [ [ 1 ] ])
  end

  subject { Veritas::Algebra::Product.new(@left, @right) }

  describe 'with relations having similar headers' do
    before do
      @right = Relation.new(@header, [ [ 2 ] ])
    end

    it { method(:subject).should raise_error(InvalidHeaderError, 'the headers must be different for Veritas::Algebra::Product.new') }
  end

  describe 'with relations having different headers' do
    before do
      @right = Relation.new([ [ :number, Integer ] ], [ [ 2 ] ])
    end

    it { method(:subject).should_not raise_error }
  end
end
