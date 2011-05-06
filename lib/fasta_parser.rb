class FastaParser
  VERSION = "0.0.1"
  
  attr_reader :input_file

  def initialize input_file
    @input_file = File.open(input_file, "r")
    #@entry = [nil,""]
    @pos_index = []
    index_fasta_file_headers()
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
  
  def read_next_entry# (n)
    #@input_file.pos = n
    #@entry[0] = @input_file.readline.chomp
    entry = [nil,""]
    entry[0] = @input_file.readline.chomp
      
    tmp_pos = @input_file.pos
    # read in sequence
    @input_file.each do |ln|
      if ln =~ /^>/
        @input_file.pos = tmp_pos
        break
      else
        #@entry[1] += ln.chomp
        entry[1] += ln.chomp
        tmp_pos = @input_file.pos
      end
    end
    return entry
  end

  def index_fasta_file_headers()    
    # at position 0
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
    return @pos_index
  end       
  
  def read_query # read_query(entry_num)
    #n = @pos_index[entry_num]
    #@pos_index[entry_num]
    #@pos_index
    #read_next_entry(n)
  end

  def entry_count
    return @pos_index.length
  end
  
  def get_accession(entry_num)
    read_query(entry_num)
    #accession = @entry[0].split(/[|]/)[3]
    #return accession
  end

  def get_definition(entry_num)
    read_query(entry_num)
    #d = @entry[0].split(/[|]/)[4]
    #definition = d.strip
    #return definition
  end
  
  
  
end

#f = FastaParser.new(input_file = ARGV[0])
