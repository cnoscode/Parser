class FastaParser
  VERSION = "0.0.1"
  
  attr_reader :input_file

  def initialize input_file
    @input_file = File.open(input_file, "r")
    #@index_position = index_fasta_file_headers()
  end

  # def check_arg
  #    unless ARGV.length == 1
  #      puts "Usage: <ruby> <file.rb> <fasta_file>"
  #      exit
  #      return false
  #    end
  #      return true
  #  end

  def read_next_entry
    entry = [nil,""]
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
    index_count = 0
    index = []
    @input_file.readline.chomp
    tmp_pos = @input_file.pos
    
    @input_file.each do |ln|
      until @input_file.eof?
        if ln =~ /^>/
          @input_file.pos = tmp_pos
          index.push(@input_file.pos)
          index_count += 1
          break
        else
          tmp_pos = @input_file.pos
        end
      end
    end
    
  end




















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

end

#p = FastaParser.new(input_file = ARGV[0])
#p.check_arg
#p.check_if_fasta
#p.check_sym
#p.get_accession
#p.get_definition