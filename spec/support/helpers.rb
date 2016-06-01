module Helpers
  def underscore(s)
    s.to_s.scan(/[A-Z][a-z]*/).join("_").downcase
  end

  def camelize(s)
    s[0] + s.to_s.split("_").each {|s| s.capitalize! }.join("")[1..-1]
  end

  def load_fixture(subject, version, method='get')
    fixture_file = File.join(SPEC_ROOT, 'fixtures', "#{version}", "#{method}-#{subject}.json")
    JSON.parse(File.read(fixture_file, :encoding => "utf-8"))
  end

  def expect_init_attribute(subject, attribute)
    expect(subject.new(camelize(attribute) => "foo").send(attribute)).to eq("foo")
  end

  def expect_read_only_attribute(subject, attribute)
    expect { subject.new.send("#{attribute}=".to_sym, "bar") }.to raise_error(NoMethodError)
  end

  def error_401
    response = {"status" => {"message" => "Foo", "status_code" => 401}}
    response.send :instance_eval do
      def code; 401; end
      def not_found?; false; end
    end
    response
  end

  def error_429
    response = {"status" => {"message" => "Foo", "status_code" => 429}}
    response.send :instance_eval do
      def code; 429; end
      def not_found?; false; end
    end
    response
  end

  def summoners
    {
        "euw" => "30743211",
        "na" => "5908",
        "eune" => "35778105"
    }
  end

  def stub_request(request_object, fixture_name, url, params={})
    request_class = request_object.class
    full_url = request_object.api_url(url, params)
    fixture_json = load_fixture(fixture_name, request_class.api_version, :get)

    expect(request_class).to receive(:get).with(full_url).and_return(fixture_json)
  end

  def stub_request_raw(request_object, raw_response, url, params={})
    request_class = request_object.class
    full_url = request_object.api_url(url, params)

    expect(request_class).to receive(:get).with(full_url).and_return(raw_response)
  end
end