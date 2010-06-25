require 'spec_helper'

describe 'Veritas::Logic::Predicate::LessThan#optimize' do
  subject { less_than.optimize }

  let(:attribute) { Attribute::Integer.new(:id, :required => false) }

  context 'left and right are attributes' do
    context 'and equivalent' do
      let(:less_than) { Logic::Predicate::LessThan.new(attribute, attribute) }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an optimize method'
    end

    context 'and are not comparable' do
      let(:other)     { Attribute::Float.new(:float)                     }
      let(:less_than) { Logic::Predicate::LessThan.new(attribute, other) }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an optimize method'
    end

    context 'and left is always less than right' do
      let(:left)      { attribute                                             }
      let(:right)     { Attribute::Integer.new(:right, :size => 2**31..2**31) }
      let(:less_than) { Logic::Predicate::LessThan.new(left, right)           }

      it { should equal(Logic::Proposition::True.instance) }

      it_should_behave_like 'an optimize method'
    end

    context 'and left is always greater than or equal to right' do
      let(:left)      { attribute                                     }
      let(:right)     { Attribute::Integer.new(:right, :size => 0..0) }
      let(:less_than) { Logic::Predicate::LessThan.new(left, right)   }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an optimize method'
    end
  end

  context 'left is an attribute' do
    context 'right is a valid value' do
      let(:less_than) { Logic::Predicate::LessThan.new(attribute, 1) }

      it { should equal(less_than) }

      it_should_behave_like 'an optimize method'
    end

    context 'right is an invalid primitive' do
      let(:less_than) { Logic::Predicate::LessThan.new(attribute, nil) }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an optimize method'
    end
  end

  context 'right is an attribute' do
    context 'left is a valid value' do
      let(:less_than) { Logic::Predicate::LessThan.new(1, attribute) }

      it { should eql(Logic::Predicate::GreaterThan.new(attribute, 1)) }

      it_should_behave_like 'an optimize method'
    end

    context 'left is an invalid primitive' do
      let(:less_than) { Logic::Predicate::LessThan.new(nil, attribute) }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an optimize method'
    end
  end

  context 'left and right are constants' do
    context 'that will evaluate to true' do
      let(:less_than) { Logic::Predicate::LessThan.new(1, 2) }

      it { should equal(Logic::Proposition::True.instance) }

      it_should_behave_like 'an optimize method'
    end

    context 'that will evaluate to false' do
      let(:less_than) { Logic::Predicate::LessThan.new(1, 1) }

      it { should equal(Logic::Proposition::False.instance) }

      it_should_behave_like 'an optimize method'
    end
  end
end
