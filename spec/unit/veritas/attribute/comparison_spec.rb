require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Attribute' do
  subject { Attribute::Integer.new(:id) }

  it { should be_kind_of(Comparable) }

  it 'case matches Comparable' do
    (Comparable === subject).should be(true)
  end
end

describe 'Veritas::Attribute#<=>' do
  before do
    @attribute = Attribute::Integer.new(:id)
  end

  subject { @attribute <=> @other }

  describe 'with an equivalent attribute' do
    before do
      @other = Attribute::Integer.new(:id)
    end

    it { should == 0 }
  end

  describe 'with a different attribute' do
    before do
      @other = Attribute::Time.new(:time)
    end

    it { should_not == 0 }
  end

  describe 'with an equivalent object responding to #to_ary' do
    before do
      @other = [ :id, Integer ]
    end

    it { should == 0 }
  end

  describe 'with a different object responding to #to_ary' do
    before do
      @other = [ :name, String ]
    end

    it { should_not == 0 }
  end
end
