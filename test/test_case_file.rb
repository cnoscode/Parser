require 'test/unit'
require 'fasta/fasta_parser'

class TestFasta < Test::Unit::TestCase

  def test_create
    p = Fasta::Parser.new("test/test.fasta")
    assert_kind_of(Fasta::Parser, p)
  end

  def test_sym
    p = Fasta::Parser.new("test/test.fasta")
    assert(p.check_sym)
  end
  
  def test_read_entry
    p = Fasta::Parser.new("test/test.fasta")
    test_entry = ">gi|329299107|ref|NM_2005745.3Acc1| Def1 zgc:65895 (zgc:65895), mRNA\nAGCTCGGGGGCTCTAGCGATTTAAGGAGCGATGCGATCGAGCTGACCGTCGCG\n"
    assert_equal(test_entry, p.read_entry(0))
  end
  
  def test_next_entry
     p = Fasta::Parser.new("test/test.fasta")
     test_entry = [">gi|329299107|ref|NM_2005745.3Acc1| Def1 zgc:65895 (zgc:65895), mRNA","AGCTCGGGGGCTCTAGCGATTTAAGGAGCGATGCGATCGAGCTGACCGTCGCG"]
     assert_equal(test_entry, p.next_entry)
  end
  
  def test_each_entry

  end
  
  def test_rewind
    p = Fasta::Parser.new("test/test.fasta")
    test_pos = 0
    assert_equal(test_pos, p.rewind)
  end
  
  def test_num_entries
    p = Fasta::Parser.new("test/test.fasta")
    test_count = 3
    assert_equal(test_count, p.entry_count)
  end

end
