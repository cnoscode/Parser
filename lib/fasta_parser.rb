class FastaParser
  VERSION = "0.0.1"
  
  attr_reader :input_file

  def initialize input_file
    @input_file = File.open(input_file)
    #@entry = [nil,""]
    @index = []
    @curr_index = 0
    index_fasta_file_headers()
  end

	def open(input_file)
		FastaParser.new(input_file)
	end
	
  def check_arg
    unless ARGV.length == 1
      puts "Usage: <ruby> <file.rb> <fasta_file>"
      exit
      return false
    end
      return true
  end
  
  def check_sym
    @input_file.each do |ln|
      if ln[0,1] == ">"
        return true
      else
        puts "Usage: Not a FASTA file!"
        exit
        return false
      end
    end
  end
	
	def rewind
		@curr_index = 0
	end
	
	def entry(n=0)	
	
	end
	
	def next_entry()
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
    return entry
  end


#class Entry 
  
  def index_fasta_file_headers()    
    # at position 0
    tmp_pos = @input_file.pos
    
    @input_file.each do |ln|
      if ln =~ /^>/ 
        @input_file.pos = tmp_pos
        @index.push(@input_file.pos)
        @input_file.readline.chomp
        tmp_pos = @input_file.pos        
      else
        tmp_pos = @input_file.pos
      end
    end
    return @index
  end       
  
  def acc
    #accession = @entry[0].split(/[|]/)[3]
  end
  
  def gi 
  
  end
  
  def description
  
  end
  
  def seq
  
  end
  
  def to_s
  
  end

end

#f = FastaParser.new(input_file = ARGV[0])
