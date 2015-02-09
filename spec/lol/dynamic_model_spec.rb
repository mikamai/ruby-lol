require 'spec_helper'
require 'lol/dynamic_model'

include Lol

describe DynamicModel do
  shared_examples 'enables date parsing' do
    let(:timestamp_value) { 1423243755000 }
    subject { DynamicModel.new attribute => timestamp_value}
    let(:attribute_value) { subject.send attribute }

    it 'and casts the value to Time' do
      expect(attribute_value).to be_a Time
    end

    it 'and divides the number by 1000' do
      expect(attribute_value.to_i).to eq timestamp_value / 1000
    end

    it 'and ignores casting when the value is not an integer' do
      subject = DynamicModel.new attribute => 'foo bar'
      expect(subject.send attribute).not_to be_a Time
    end
  end

  context 'when is not initialized with an hash' do
    subject { DynamicModel.new 'not enumerable data' }

    it 'raises an argument error' do
      expect{ subject }.to raise_error ArgumentError, 'An hash is required as parameter'
    end
  end

  context 'when initialized with hash' do
    subject { DynamicModel.new key: 'value' }

    it 'does not raise error' do
      expect { subject }.not_to raise_error
    end

    it 'defines a method per each argument key' do
      expect(subject).to respond_to(:key)
    end
  end

  %w(date at).each do |attr_name|
    context "when an hash key is called '#{attr_name}'" do
      it_behaves_like 'enables date parsing' do
        let(:attribute) { attr_name }
      end
    end

    context "when an hash key ends with '_#{attr_name}'" do
      it_behaves_like 'enables date parsing' do
        let(:attribute) { "a2342_#{attr_name}"}
      end
    end
  end

  context "when an hash value is an array" do
    it 'preserves the array' do
      subject = DynamicModel.new foo: ['foo']
      expect(subject.foo).to eq ['foo']
    end

    context 'and one or more array items are hashes' do
      subject { DynamicModel.new foo: [{}] }

      it 'casts each hash to another DynamicModel instance' do
        expect(subject.foo.map(&:class).uniq).to eq [DynamicModel]
      end
    end
  end
end
