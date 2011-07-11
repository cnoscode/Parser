class Entry 
	require 'lib/fasta_parser'
  
  attr_accessor :desc, :acc, :seq, :gi
  
  def initialize fasta_file
  	FastaParser.new(fasta_file)
  	@desc = [] # entry[0]
  	@seq = [] # entry[1]
  	@acc = ""
  	@gi = ""
  end
  
  def desc(entry)	
		@desc = entry[0].sub(/>/, '')
  	return @desc
  end
  
  def acc(entry)
    @acc = entry[0].split(/[|]/)[3]
    return @acc
  end
  
  def gi(entry)
  	gi = entry[0].split(/[|]/)[1]
  	@gi = gi.to_i
  	return @gi
  end
  
  def seq(entry) 
  	@seq = entry[1]
  	return @seq
  end
	
	def to_s(entry)
		entry.collect! {|e| e + "\n"}		
		formatted_string = ""
		entry.each {|a| formatted_string << "#{a.to_s}"}
		return formatted_string
	end
	
end