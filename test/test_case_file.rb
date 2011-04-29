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
    p = FastaParser.new("test/test.fasta")
    assert(p.check_sym == true)
  end
  
  def test_read_file

    f = File.open("test/test.fasta", "r")
    #e = f.enum_for(:each)
    #e.each_slice(2) do |buf1,buf2|
    #  p "Buffer 1: #{buf1}"
    #  p "Buffer 2: #{buf2}"
    #end
    $/ = "\n\n"
    f.each do |buf|
      buffer = buf.sub(/\n+ \z/xms, "")
      p "Content in buffer: #{buffer}"
      accession = buffer.split(/[|]/)[3]
      p "Accesion: #{accession}"
        if f.eof? 
          puts "End of file."
        end
    end
    p "Cursor position: #{f.pos}"
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
