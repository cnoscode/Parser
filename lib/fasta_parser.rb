class FastaParser
  VERSION = "0.0.1"
  
  attr_reader :fasta_file

  def initialize fasta_file
    @fasta_file = File.open(fasta_file)
    @index = []
    @curr_index = 0
    index_headers()
  end
  
  # returns instance of class
  def open(fasta_file)
    FastaParser.new(fasta_file)
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
    @fasta_file.each do |ln|
      if ln[0,1] == ">"
        return true
      else
        puts "Usage: Not a FASTA file!"
        exit
        return false
      end
    end
  end
  
  # rewinds to beginning index
  def rewind
  	# self.rewind
    @curr_index = 0
  end
  
  def read_entry(n) 
  	if n
      @curr_index = n
    end 
    #tmp_pos
    self.pos = @index[@curr_index]   
  end
  
  # returns specific entry 
  def entry(n=nil)  
    self.read_entry(n)
  end
  
  # returns next entry in file
  def next_entry
  	@fasta_file.pos = 0
    entry = [nil,""]
    entry[0] = @fasta_file.readline.chomp
      
    tmp_pos = @fasta_file.pos
    # read in sequence
    @fasta_file.each do |ln|
      if ln =~ /^>/
        @fasta_file.pos = tmp_pos
        break
      else
        entry[1] += ln.chomp
        tmp_pos = @fasta_file.pos
      end
    end
    return entry
  end
  
  # returns index of positions
  def index_headers()    
    # at position 0
    tmp_pos = @fasta_file.pos
    
    @fasta_file.each do |ln|
      if ln =~ /^>/ 
        @fasta_file.pos = tmp_pos
        @index.push(@fasta_file.pos)
        @fasta_file.readline.chomp
        tmp_pos = @fasta_file.pos        
      else
        tmp_pos = @fasta_file.pos
      end
    end
    return @index
  end       
end

class Entry 
  
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