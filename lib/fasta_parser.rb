class FastaParser
  include Enumerable
    
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
  
  def check_sym
    @fasta_file.each do |ln|
      if ln[0,1] == ">"
        return true
      else
        return false
      end
    end
  end
  
  # rewinds to beginning index
  def rewind
    @curr_index = 0
  end
  
  def read_entry(n)
    @curr_index = n
    self.pos = @index[@curr_index]
    @curr_index += 1  
  end
  
  # returns next entry in file
  def next_entry
    # @fasta_file.pos = n
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
  
  def each_entry
    yield self.entry
  end
  
  def entry(n)
    Fasta::Entry.new(read_entry(n))
  end
  
  def entry_count
    return @index.length
  end
  
  private
  
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