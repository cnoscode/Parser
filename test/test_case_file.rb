require 'test/unit'
require 'fasta_parser'

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
    entry = f.read_next_entry#(0)
    assert_equal(test_entry, entry)
  end

  def test_index
    f = FastaParser.new("test/test.fasta")
    test_file_pos = [0, 123, 287]
    pos_index = f.index_fasta_file_headers
    assert_equal(test_file_pos, pos_index)
  end
  
  def test_second_entry # passing position
    f = FastaParser.new("test/test.fasta")
    second_entry = [">gi|329299107|ref|NM_2342343.3Acc2| Def2 zgc:65895 (zgc:65895), mRNA", "GTCGCTGGGTCGAAAAGTGGTGCTATATCGCGGCTCGCGTCGATGTCGCGATGCGTGCGCGCGAGAGCGCGCTATGATGAAAGGATGAGAGAG"]
    assert_equal(second_entry,f.read_query)
  end
  
  def test_entry_count
    f = FastaParser.new("test/test.fasta")
    test_count = 3 
    actual_num = f.entry_count
    assert_equal(test_count, actual_num)
  end
      
  # checks accession 
  def test_accession
#    f = FastaParser.new("test/test.fasta")
#    test_accession = "NM_2005745.3Acc1"
#    accession = f.get_accession(0)
#    assert_equal(test_accession, accession)
  end

  # checks definition 
  def test_definition
#    f = FastaParser.new("test/test.fasta")
#    test_definition = "Def1 zgc:65895 (zgc:65895), mRNA"
#    definition = f.get_definition(0)
#    assert_equal(test_definition, definition)
  end

  # checks sequence
  def test_sequence
#    f = FastaParser.new("test/test.fasta")
    
    
  end



end
