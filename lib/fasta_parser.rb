class FastaParser
	require 'fasta/entry'
	
  VERSION = "0.0.1"
  
  attr_reader :fasta_file

  def initialize fasta_file
    @fasta_file = File.open(fasta_file)
    @index = []
    @curr_index = 0
    @entry_index = []
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
  	@curr_index = 0
  end
  
  def entry(n)
		if n 
			@curr_index = n
		end
    #tmp_pos
    n = @index[@curr_index]
    self.next_entry(n)
  end
  
  # returns next entry in file
  def next_entry(n)
  	@fasta_file.pos = n
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
    self.rewind # back to pos 0
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
  
  def each_entry
  	# at position 0
    tmp_pos = @fasta_file.pos
    
    @fasta_file.each do |entry|
			if entry =~ /^>/
        @fasta_file.pos = tmp_pos
        @fasta_file.readline.chomp
        @entry_index.push(entry)
        tmp_pos = @fasta_file.pos              
			else
        tmp_pos = @fasta_file.pos				
			end
    end
    return @entry_index
  end
  
  # returns number of entries
  def entry_count
  	return @index.length
  end
  
end


#f = FastaParser.new(input_file = ARGV[0])