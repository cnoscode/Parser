class FastaParser
  VERSION = "0.0.1"
  
  attr_reader :input_file, :fasta_is_open
  
  def initialize input_file
    @input_file = input_file
    @fasta_is_open = fasta_is_open
  end
  
  def check_arg
    unless ARGV.length == 1
      puts "Usage: <ruby> <file.rb> <fasta_file>"
      exit
      return false
    end
      return true
  end
  
  def check_if_fasta
    unless @input_file.downcase[-6..-1] == ".fasta"
      puts "Usage: File needs '.fasta' extension!"
      exit
      return false
    end
      return true
  end
  
  def check_sym
    @fasta_is_open = File.open(@input_file, "r")
    first_sym = @fasta_is_open.each_char.to_a
    unless first_sym[0] == ">"
      puts "Usage: Not a fasta file!"
      exit
      return false
    end
      return true
  end
  
  def get_accession
    @fasta_is_open = File.open(@input_file, "r")
    array = @fasta_is_open.to_a
    accession = array[0].split(/[|]/)[3]
    return true
  end
  
  def get_definition
    @fasta_is_open = File.open(@input_file, "r")
    array = @fasta_is_open.to_a
    d = array[0].split(/[|]/)[4]
    definition = d.strip
    return true
  end
  
  def get_sequence
    
  end
  
end

#p = FastaParser.new(input_file = ARGV[0])
#p.check_arg
#p.check_if_fasta
#p.check_sym
#p.get_accession
#p.get_definition