require 'test/unit'
require 'fasta_parser'
require 'fasta/entry'

class TestFasta < Test::Unit::TestCase

  def test_create
    f = FastaParser.new("test/test.fasta")
    assert_kind_of(FastaParser, f)
  end

  def test_sym
    f = FastaParser.new("test/test.fasta")
    assert(f.check_sym)
  end

  def test_read_entry
#     f = FastaParser.new("test/test.fasta")
#     test_entry = [">gi|329299107|ref|NM_2005745.3Acc1| Def1 zgc:65895 (zgc:65895), mRNA","AGCTCGGGGGCTCTAGCGATTTAAGGAGCGATGCGATCGAGCTGACCGTCGCG"]
#     entry = f.entry(0)
#     assert_equal(test_entry, entry)
  end
  
  def test_each_entry

  end
  
  def test_rewind
    f = FastaParser.new("test/test.fasta")
    test_pos = 0
    actual_pos = f.rewind
    assert_equal(test_pos, actual_pos)
  end
  
  def test_num_entries
    f = FastaParser.new("test/test.fasta")
    test_count = 3
    actual_count = f.entry_count
    assert_equal(test_count, actual_count)
  end

end
