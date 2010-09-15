require 'spec_helper'

describe 'Veritas::Relation::Operation::Order::Descending.call' do
  subject { Relation::Operation::Order::Descending.call(left, right) }

  context 'when left is equal to right' do
    let(:left)  { 1 }
    let(:right) { 1 }

    it { should be(0) }
  end

  context 'when left is greater than right' do
    let(:left)  { 2 }
    let(:right) { 1 }

    it { should be(-1) }
  end

  context 'when left is less than right' do
    let(:left)  { 1 }
    let(:right) { 2 }

    it { should be(1) }
  end
end