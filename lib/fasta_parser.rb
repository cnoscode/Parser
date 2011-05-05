class FastaParser
  VERSION = "0.0.1"
  
  attr_reader :input_file

  def initialize input_file
    @input_file = File.open(input_file, "r")
    @pos_index = []
    #index_fasta_file_headers()
  end

  # def check_arg
  #    unless ARGV.length == 1
  #      puts "Usage: <ruby> <file.rb> <fasta_file>"
  #      exit
  #      return false
  #    end
  #      return true
  #  end
  
  def read_next_entry(n)
    entry = [nil,""]
    @input_file.pos = n
    entry[0] = @input_file.readline.chomp
    
    
    tmp_pos = @input_file.pos
    # read in sequence
    @input_file.each do |ln|
      if ln =~ /^>/
        @input_file.pos = tmp_pos
        break
      else
        entry[1] += ln.chomp
        tmp_pos = @input_file.pos
      end
    end
    entry
  end

  def index_fasta_file_headers()    

    # at file position 0
    tmp_pos = @input_file.pos
    
    @input_file.each do |ln|
      if ln =~ /^>/ 
        @input_file.pos = tmp_pos
        @pos_index.push(@input_file.pos)
        @input_file.readline.chomp
        tmp_pos = @input_file.pos        
      else
        tmp_pos = @input_file.pos
      end
    end
    @pos_index
  end       
  
  def read_query(n)
    read_next_entry(n)
  end

  def entry_count
    return @pos_index.length
  end
  
=begin  
  def check_sym
    symbol = @input_file.read(1)
    unless symbol == ">"
      puts "Usage: Not a FASTA file!"
      exit
      return false
    end
      return true
  end

  def get_accession
    array = @input_file.to_a
    accession = array[0].split(/[|]/)[3]
    return true
    @fasta_is_open.close
  end

  def get_definition
    @fasta_is_open = File.open(@input_file, "r")
    array = @fasta_is_open.to_a
    d = array[0].split(/[|]/)[4]
    definition = d.strip
    return true
    @fasta_is_open.close
  end
=end
end

#p = FastaParser.new(input_file = ARGV[0])
#p.check_arg
#p.check_if_fasta
#p.check_sym
#p.get_accession
#p.get_definition