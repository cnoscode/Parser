class FastaParser
  VERSION = "0.0.1"
  
  attr_reader :input_file
  
  def initialize input_file
    @input_file = input_file
  end
  
  def check_arg
    unless ARGV.length == 1
      puts "Usage: <ruby> <file.rb> <fasta_file>"
      return false
    end
      return true
  end
  
  def check_if_fasta
    unless @input_file.downcase[-6..-1] == ".fasta"
      puts "Usage: File needs '.fasta' extension!"
      return false
    end
      return true
  end
  
  def check_sym
    @f = File.open(@input_file, "r")
    first_sym = @f.each_char.to_a
    unless first_sym[0] == ">"
      puts "Usage: Not a fasta file!"
      return false
    end
      return true
  end
  
  def get_first_entry 
    
  end
  
end

p = Parser.new(input_file = ARGV[0])
p.check_arg
p.check_if_fasta
p.check_sym