class Entry 
	require 'lib/fasta_parser'
  
  attr_accessor :desc, :acc, :seq, :gi
  
  def initialize entry
  	@desc = [] # entry[0]
  	@seq = [] # entry[1]
  	@acc = ''
  	@gi = ''
  end
  
  def desc(entry)	
		@desc = entry[0].sub(/>/, '')
  	return @desc
  end
  
  def acc(entry)
    @acc = entry[0].split(/[|]/)[3]
    return @acc
  end
  
  def seq(entry) 
  	@seq = entry[1]
  	return @seq
  end
	
	def to_s
		# returns well formatted FASTA entry as a String
		# >desc\nsequence\n
	end
	
end