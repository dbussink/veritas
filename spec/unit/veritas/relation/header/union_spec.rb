require File.expand_path('../../../../../spec_helper', __FILE__)

describe 'Veritas::Relation::Header#union' do
  before do
    @attribute1 = mock('Attribute 1')
    @attribute2 = mock('Attribute 2')

    @body  = Relation::Header.new([ @attribute1 ])
    @other = Relation::Header.new([ @attribute2 ])
  end

  subject { @body.union(@other) }

  it { should be_kind_of(Relation::Header) }

  it { subject.should == [ @attribute1, @attribute2 ] }
end

describe 'Veritas::Relation::Header#|' do
  it 'is an alias to #union' do
    Relation::Header.instance_method(:|).should == Relation::Header.instance_method(:union)
  end
end