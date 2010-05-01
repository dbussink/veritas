require File.expand_path('../../../../spec_helper', __FILE__)

describe 'Veritas::Tuple#eql?' do
  before do
    @header = Relation::Header.new([ [ :id, Integer ] ])
    @tuple  = Tuple.new(@header, [ 1 ])
  end

  subject { @tuple.eql?(@other) }

  describe 'with the same tuple' do
    before do
      @other = @tuple
    end

    it { should be(true) }

    it 'is symmetric' do
      should == @other.eql?(@tuple)
    end
  end

  describe 'with an equivalent tuple' do
    before do
      @other = @tuple.dup
    end

    it { should be(true) }

    it 'is symmetric' do
      should == @other.eql?(@tuple)
    end
  end

  describe 'with a different tuple' do
    before do
      @other = Tuple.new(@header, [ 2 ])
    end

    it { should be(false) }

    it 'is symmetric' do
      should == @other.eql?(@tuple)
    end
  end

  describe 'with an equivalent tuple with a different header' do
    before do
      @header = @header.rename(:id => :other_id)
      @other  = Tuple.new(@header, @tuple.to_ary)
    end

    it { should be(false) }

    it 'is symmetric' do
      should == @other.eql?(@tuple)
    end
  end

  describe 'with an equivalent tuple of a different class' do
    before do
      klass = Class.new(Tuple)

      @other = klass.new(@header, [ 1 ])
    end

    it { should be(false) }

    it 'is symmetric' do
      should == @other.eql?(@tuple)
    end
  end

  describe 'with an equivalent object responding to #to_ary' do
    before do
      @other = [ 1 ]
    end

    it { should be(false) }

    specification = proc do
      should == @other.eql?(@tuple)
    end

    it 'is symmetric' do
      if RUBY_PLATFORM[/java/]
        pending('Array#eql? does not call other#to_ary in JRuby', &specification)
      else
        instance_eval(&specification)
      end
    end
  end

  describe 'with a different object responding to #to_ary' do
    before do
      @other = [ 2 ]
    end

    it { should be(false) }

    it 'is symmetric' do
      should == @other.eql?(@tuple)
    end
  end
end
