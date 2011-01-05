require 'test/unit'

$:.push File.expand_path(File.join(File.dirname(__FILE__), '..', 'lib'))
require 'jazor'


class TestExecute < Test::Unit::TestCase

  def test_without_paramaters()
    assert `./bin/jazor` == "{}\n"
  end

  def test_bad_json()
    assert `./bin/jazor http://example.com` =~ /^Error/
  end

  def test_with_source()
    assert eval(`./bin/jazor ./test/test.json`).is_a?(Hash)
  end

  def test_with_source_and_slice()
    assert eval(`./bin/jazor ./test/test.json nested_object`).is_a?(Hash)
    assert eval(`./bin/jazor ./test/test.json nested_object.array_of_values`).is_a?(Array)
    assert eval(`./bin/jazor ./test/test.json dontexist`).nil?
  end

  def test_with_source_and_tests()
    assert `./bin/jazor ./test/test.json -t 'value1==123'` =~ /(Passed)/
    assert `./bin/jazor ./test/test.json -t 'value1==1234'` =~ /(Failed)/
  end

end
