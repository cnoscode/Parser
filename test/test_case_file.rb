require 'test/unit'
require 'test_file_parse'

class TestFasta < Test::Unit::TestCase
  
  def test_arg
    p = Parser.new(ARGV[0] = "test/test.fasta")
    assert(p.check_arg == true)
  end
  
  def test_file
    p = Parser.new("test/test.fasta")
    assert(p.check_if_fasta == true)
  end
  
  def test_sym
    f = File.open("test/test.fasta", "r")
    first_sym = f.each_char.to_a
    assert_equal(">", first_sym[0])
  end
  
end