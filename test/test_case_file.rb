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
    f = FastaParser.new("test/test.fasta")
    test_entry = [">gi|329299107|ref|NM_2005745.3Acc1| Def1 zgc:65895 (zgc:65895), mRNA","AGCTCGGGGGCTCTAGCGATTTAAGGAGCGATGCGATCGAGCTGACCGTCGCG"]
    entry = f.entry(0)
    assert_equal(test_entry, entry)
  end
  
  def test_each_entry
    f = FastaParser.new("test/test.fasta")
		test_entry = "h"
		entry = f.each_entry
		assert_equal(test_entry, entry)
  end

  def test_index
    f = FastaParser.new("test/test.fasta")
    test_file_pos = [0, 123, 287]
    pos_index = f.index_headers()
    assert_equal(test_file_pos, pos_index)
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
  
  def test_desc
  	e = Entry.new("test/test.fasta")
    f = FastaParser.new("test/test.fasta")
    entry = f.entry(0)
    test_desc = "gi|329299107|ref|NM_2005745.3Acc1| Def1 zgc:65895 (zgc:65895), mRNA"
    description = e.desc(entry)
    assert_equal(test_desc, description)
  end
  
  def test_acc
    e = Entry.new("test/test.fasta")
    f = FastaParser.new("test/test.fasta")
    entry = f.entry(0)
    test_acc = "NM_2005745.3Acc1"
    accession = e.acc(entry)
    assert_equal(test_acc, accession)
  end
  
  def test_gi
    e = Entry.new("test/test.fasta")
    f = FastaParser.new("test/test.fasta")
    entry = f.entry(0)
    test_gi = 329299107
    actual_gi = e.gi(entry)
    assert_equal(test_gi, actual_gi)
  end
  
  def test_seq
		e = Entry.new("test/test.fasta")
    f = FastaParser.new("test/test.fasta")
    entry = f.entry(0)
    test_seq = "AGCTCGGGGGCTCTAGCGATTTAAGGAGCGATGCGATCGAGCTGACCGTCGCG"
    sequence = e.seq(entry)
    assert_equal(test_seq, sequence)
  end
  
  def test_formatted_string
  	e = Entry.new("test/test.fasta")
  	f = FastaParser.new("test/test.fasta")
  	entry = f.entry(0)
  	test_string = ">gi|329299107|ref|NM_2005745.3Acc1| Def1 zgc:65895 (zgc:65895), mRNA\nAGCTCGGGGGCTCTAGCGATTTAAGGAGCGATGCGATCGAGCTGACCGTCGCG\n"
  	actual_string = e.to_s(entry)
  	assert_equal(test_string, actual_string)
  end

end
