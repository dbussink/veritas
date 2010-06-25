require 'spec_helper'

describe 'Veritas::Relation::Materialized#optimize' do
  subject { relation.optimize }

  context 'with an empty Array' do
    let(:relation) { Relation::Materialized.new([ [ :id, Integer ] ], []) }

    it { should eql(Relation::Empty.new(relation.header)) }

    it 'returns an equivalent relation to the unoptimized operation' do
      should == relation
    end

    it_should_behave_like 'an optimize method'
  end

  context 'with an nonempty Array' do
    let(:relation) { Relation::Materialized.new([ [ :id, Integer ] ], [ [ 1 ] ]) }

    it { should equal(relation) }

    it_should_behave_like 'an optimize method'
  end
end
