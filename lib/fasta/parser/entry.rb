module Fasta
  class Parser
    class Entry 
      
      attr_accessor :gi, :desc, :acc, :seq
      
      def initialize(entry)
        @gi = ""
        @desc = []
        @acc = ""
        @seq = []
        parse(entry)
      end
      
      def to_s
        #entry.collect! {|e| e + "\n"}    
        #formatted_string = ""
        #entry.each {|a| formatted_string << "#{a.to_s}"}
        #return formatted_string
      end
      
      private
      def parse(entry)
      	@gi = entry.split(/[|]/)[1]
      	@acc = entry.split(/[|]/)[3]
      	# @seq 
       	@desc = entry.readline.chomp       	
      end
      
    end
  end
end