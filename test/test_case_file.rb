require 'test/unit'
require 'fasta_parser'

class TestFasta < Test::Unit::TestCase
  
  def test_arg
    p = FastaParser.new(ARGV[0] = "test/test.fasta")
    assert(p.check_arg == true)
  end
  
  def test_file
    p = FastaParser.new("test/test.fasta")
    assert(p.check_if_fasta == true)
  end
  
  def test_sym
    f = File.open("test/test.fasta", "r")
    first_sym = f.each_char.to_a
    assert_equal(">", first_sym[0])
  end
  
  def test_accession
    f = File.open("test/test_entry.fasta","r")
  end
  
end