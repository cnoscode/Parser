require 'test/unit'
require 'test_file_parse'

class TestFasta < Test::Unit::TestCase
  
  def test_arg
    p = Parser.new("test/test.fasta")
    assert(p.check_arg == true)
  end
  
  def test_file
    p = Parser.new("test/test.fasta")
    assert(p.check_if_fasta == true)
  end
  
  def test_sym
    p = Parser.new("test/test.fasta") 
    assert(p.check_sym == true)
  end
  
end