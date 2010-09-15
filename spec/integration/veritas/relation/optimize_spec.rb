require 'spec_helper'

describe 'Veritas::Relation#optimize' do
  subject { object.optimize(*args) }

  let(:klass)  { Relation                                        }
  let(:object) { klass.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }

  context 'with no optimizer' do
    let(:args) { [] }

    it 'calls self.class.optimizer' do
      klass.should_receive(:optimizer).and_return(nil)
      subject
    end

    it { should equal(object) }

    it_should_behave_like 'an optimize method'
  end

  context 'with an optimizer' do
    let(:optimized) { klass.new([ [ :id, Integer ] ], [ [ 1 ] ].each) }
    let(:args)      { [ lambda { |relation| optimized } ]             }

    it { should equal(optimized) }

    it_should_behave_like 'an optimize method'
  end
end