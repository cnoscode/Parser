module Fasta
  class Parser
    require 'lib/fasta/parser/entry'
      
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
      Fasta::Parser.new(fasta_file)
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
      length = ""
      
      return nil if @index[@curr_index].nil?
   
      @fasta_file.pos = @index[@curr_index]
      @curr_index += 1      
                     
      if @index[@curr_index].nil?
      	entry = @fasta_file.read until @fasta_file.eof
      else
      	length = @index[@curr_index] - @fasta_file.pos
      	entry = @fasta_file.read(length)
      end
       
      return entry
    end
    
    # returns next entry in file
    def next_entry
    	return nil if @fasta_file.eof?

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
      #return nil if entry.nil?
    end
    
    def each
    	# while file is not at the end of file, return Entry class
    	while !@fasta_file.eof?
        yield self.entry() if block_given?
      end
    end
    
    def entry(n)
      Fasta::Parser::Entry.new(self.read_entry(n))
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
      @fasta_file.rewind
      return @index
    end
    
  end
end