require 'test/unit'
require 'fasta_parser'

class TestFasta < Test::Unit::TestCase

  def test_create
    p = FastaParser.new("test/test.fasta")
    assert_kind_of(FastaParser, p)
  end

  def test_sym
    p = FastaParser.new("test/test.fasta")
    assert(p.check_sym)
  end

  def test_read_entry
    f = FastaParser.new("test/test.fasta")
    test_entry = [">gi|329299107|ref|NM_2005745.3Acc1| Def1 zgc:65895 (zgc:65895), mRNA","AGCTCGGGGGCTCTAGCGATTTAAGGAGCGATGCGATCGAGCTGACCGTCGCG"]
    entry = f.read_next_entry
    assert_equal(test_entry[0], entry[0])
    assert_equal(test_entry[1], entry[1])
  end


=begin
  # checks accession for first entry
  def test_accession
    p = FastaParser.new("test/test.fasta")
    assert(p.get_accession == true)

    f = File.open("test/test.fasta","r")
    array = f.to_a
    accession = array[0].split(/[|]/)[3]
    assert_equal("NM_2005745.3Acc1", accession)
  end

  # checks definition for first entry
  def test_definition
    f = File.open("test/test.fasta","r")
    array = f.to_a
    d = array[0].split(/[|]/)[4]
    definition = d.strip
    assert_equal("Def1 zgc:65895 (zgc:65895), mRNA", definition)
  end

  # checks sequence match (NOTE: only one entry in file)
  def test_sequence
    f = File.open("test/test_entry.fasta","r")
    array = f.to_a
    seq_with_newline = ''
    sequence = ''
    array.drop(1).each do |element|
      seq_with_newline += element
      sequence = seq_with_newline.delete("\n")
    end
    assert_equal("AGCTCGGGGGCTCTAGCGATTTAAGGAGCGATGCGATCGAGCTGACCGTCGCGAAGGAGCGGTGAGGGAGAGGAGAGAGGA", sequence)
  end
=end


end
