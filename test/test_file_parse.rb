class Parser
  
  attr_reader :input_file
  
  def initialize input_file
    @input_file = input_file
  end
  
  def check_arg
    unless ARGV.length == 1
      puts "Usage: Need a fasta file!"
      return false
    end
      return true
  end
  
  def check_if_fasta
    unless @input_file.downcase[-6..-1] == ".fasta"
      return false
    end
      return true
  end
  
  def check_sym
    f = File.open(@input_file, "r")
    first_sym = f.each_char.to_a
    unless first_sym[0] == ">"
      return false
    end
      return true
  end
  
end

#p = Parser.new(input_file = ARGV[0])
#p.check_arg