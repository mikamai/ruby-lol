shared_examples 'attribute' do
  let(:setter) { "#{attribute}=" }

  it 'is read only' do
    expect(subject).to_not respond_to setter
  end
end

shared_examples 'Lol model' do
  let(:subject_class) { subject.class }

  describe '#new' do
    it "takes an option hash as argument" do
      expect { subject_class.new valid_attributes }.not_to raise_error
    end

    it 'raises an error if an attribute is not allowed' do
      expect { subject_class.new({ :foo => :bar }) }.to raise_error NoMethodError
    end

    it 'sets the given option hash as #raw' do
      expect(subject_class.new(valid_attributes).raw).to eq valid_attributes
    end
  end

  describe '#raw' do
    it_behaves_like 'attribute' do
      let(:attribute) { 'raw' }
    end
  end
end

shared_examples 'plain attribute' do
  let(:subject_class) { subject.class }
  let(:setter) { "#{attribute}=" }

  it_behaves_like 'attribute'

  context 'during #new' do
    it 'is set if the hash contains the attribute name "underscored"' do
      model = subject_class.new attribute => attribute_value
      expect(model.send attribute).to eq attribute_value
    end

    it 'is set if the hash contains the attribute name "camelized"' do
      model = subject_class.new camelize(attribute) => attribute_value
      expect(model.send attribute).to eq attribute_value
    end
  end
end

shared_examples 'time attribute' do
  let(:subject_class) { subject.class }
  let(:setter) { "#{attribute}=" }

  it_behaves_like 'plain attribute' do
    let(:attribute_value) { Time.now }
  end

  it "does not parse the value is it isn't a Numeric value" do
    model = subject_class.new(attribute => Date.today)
    expect(model.send attribute).to be_a Date
  end

  it "works with LoL format" do
    model = subject_class.new(attribute => 1386804971247)
    expect(model.send(attribute).year).to eq 2013
  end
end

shared_examples 'collection attribute' do
  let(:subject_class) { subject.class }
  let(:setter) { "#{attribute}=" }

  it_behaves_like 'attribute'

  it 'is sets if the hash contains the attribute name "underscored"' do
    value = respond_to?(:attribute_value) && attribute_value || [{}, {}]
    model = subject_class.new({ attribute => value })
    expect(model.send(attribute).size).to eq 2
  end

  it 'is set if the hash contains the attribute name "camelized"' do
    value = respond_to?(:attribute_value) && attribute_value || [{}, {}]
    model = subject_class.new({ camelize(attribute) => value })
    expect(model.send(attribute).size).to eq 2
  end

  context 'if the value is not enumerable' do
    it 'raises an error' do
      expect {
        subject_class.new({ attribute => 'asd' })
      }.to raise_error NoMethodError
    end
  end

  context 'if the value is enumerable' do
    context 'and contains items as Hash' do
      it 'parses the item' do
        value = respond_to?(:attribute_value) && attribute_value || [{}, {}]
        model = subject_class.new attribute => value
        expect(model.send(attribute).map(&:class).uniq).to eq [attribute_class]
      end
    end

    context 'and contains items as non-Hash' do
      it 'does not parse the item' do
        model = subject_class.new attribute => [attribute_class.new, Object.new]
        expect(model.send(attribute).map(&:class).uniq).to eq [attribute_class, Object]
      end
    end
  end
end
