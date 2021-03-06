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
  
  def test_read_first_entry 
    p = Fasta::Parser.new("test/test.fasta")
    test_entry = ">gi|329299107|ref|NM_2005745.3Acc1| Def1 zgc:65895 (zgc:65895), mRNA\nAGCTCGGGGGCTCTAGCGATTTAAGGAGCGATGCGATCGAGCTGACCGTCGCG\n"
    assert_equal(test_entry, p.read_entry(0))
  end
  
  def test_read_second_entry
    p = Fasta::Parser.new("test/test.fasta")
    test_entry = ">gi|329299107|ref|NM_2342343.3Acc2| Def2 zgc:65895 (zgc:65895), mRNA\nGTCGCTGGGTCGAAAAGTGGTGCTATATCGCGGCTCGCGTCGATGTCGCGATG\nCGTGCGCGCGAGAGCGCGCTATGATGAAAGGATGAGAGAG\n"
    assert_equal(test_entry, p.read_entry(1))  
  end
  
  def test_next_entry
    p = Fasta::Parser.new("test/test.fasta")
    test_entry = [">gi|329299107|ref|NM_2005745.3Acc1| Def1 zgc:65895 (zgc:65895), mRNA","AGCTCGGGGGCTCTAGCGATTTAAGGAGCGATGCGATCGAGCTGACCGTCGCG"]
    assert_equal(test_entry, p.next_entry)
  end
  
  def test_first_entry_object
    p = Fasta::Parser.new("test/test.fasta")    
    test_seq = "AGCTCGGGGGCTCTAGCGATTTAAGGAGCGATGCGATCGAGCTGACCGTCGCG"
    test_gi = 329299107
    test_acc = "NM_2005745.3Acc1"
    test_def = "Def1 zgc:65895 (zgc:65895), mRNA"
    test_desc = "gi|329299107|ref|NM_2005745.3Acc1| Def1 zgc:65895 (zgc:65895), mRNA"
    
    first_entry = p.entry(0)        
    assert_equal(test_seq, first_entry.seq)
    assert_equal(test_gi, first_entry.gi)
    assert_equal(test_acc, first_entry.acc)
    assert_equal(test_def, first_entry.defin)
    assert_equal(test_desc, first_entry.desc)
  end

  def test_rewind
    p = Fasta::Parser.new("test/test.fasta")
    assert_equal(0, p.rewind)
  end
  
  def test_num_entries
    p = Fasta::Parser.new("test/test.fasta")
    assert_equal(3, p.entry_count)
  end
  
  def test_each
    p = Fasta::Parser.new("test/test.fasta")
#   f = File.open("test/test.fasta")
    p.each do |entry|
      assert_kind_of(Fasta::Parser::Entry, p.each)
    end   
  end

end
