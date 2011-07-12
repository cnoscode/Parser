module Fasta
  class Parser
    #require 'fasta/parser/entry'
      
    VERSION = "0.0.1"
    
    attr_reader :fasta_file
  
    def initialize fasta_file
      @fasta_file = File.open(fasta_file)
      @index = []
      @curr_index = 0
      index_positions()
    end
    
    # returns instance of class
    def open(fasta_file)
      Parser.new(fasta_file)
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
      @fasta_file.pos = @index[@curr_index]
      @curr_index += 1
      
      # subtract new current position from file position to get length  
      length = @index[@curr_index] - @fasta_file.pos 
      @fasta_file.read(length)
    end
    
    # returns next entry in file
    def next_entry  
      entry = [nil,""]
      if @fasta_file.eof?
        self.rewind
      end
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
      while !@fasta_file.eof
        yield self.entry() if block_given?
      end
    end
    
    def entry(n)
      Fasta::Parser::Entry.new(read_entry(n))
    end
    
    def entry_count
      return @index.length
    end
    
    private
    
    def index_positions()    
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
end