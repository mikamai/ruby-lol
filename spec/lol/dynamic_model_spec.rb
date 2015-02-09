require 'spec_helper'
require 'lol/dynamic_model'

include Lol

describe DynamicModel do
  describe 'when is not initialized with hash' do
    subject { DynamicModel.new 'not enumerable data' }
    it 'raise error' do
      expect{ subject }.to raise_error
    end
  end

  describe 'when initialized with hash' do
    subject { DynamicModel.new [] }
    it 'do not raise error' do
      expect{ subject }.not_to raise_error
    end

    describe 'as key value hash' do
      subject { DynamicModel.new({ key: 'value' }) }
      it 'define method as passed key' do
        expect(subject).to respond_to(:key)
      end
    end

    describe 'as array of hashes' do
      subject { DynamicModel.new([:first,{second: 'value'}]) }
      it 'first' do
        expect(subject).to respond_to(:first)
      end
    end
  end

  describe 'when passed key parameter include *date and value is fixnum' do
    subject { DynamicModel.new({current_date: 1423243755000}) }
    it 'should cast value to Time' do
      expect(subject.current_date).to be_a Time
    end
  end

  describe 'when passed key parameter include *at and value is not fixnum' do
    subject { DynamicModel.new({updated_at: '12344212'}) }
    it 'should not cast value to Time' do
      expect(subject.updated_at).not_to be_a Time
    end
  end

end
