module Fasta
  class Parser
    class Entry 
      
      attr_accessor :gi, :desc, :acc, :seq
      
      def initialize(entry)
        # string check from read_entry
        if entry.is_a? String
          entry = entry.split(/\n/)
        end
                        
        @gi = ""
        @desc = ""
        @acc = ""
        @seq = ""
        parse(entry)
      end
      
      def to_s
        formatted_entry =">#{@desc}\n"
        byte_count = 0
        
        @seq.each_byte do |b|
          byte_count += 1
          if byte_count > 80
            formatted_entry += "#{@seq}\n"
            byte_count = 0
          else
            formatted_entry += "#{@seq}\n"
            break
          end
        end
        
        formatted_entry.to_s                 
      end
      
      private
      def parse(entry)
        return nil if entry.nil?      
        entry[0].slice!(0)
        
        @desc = entry[0]        
        @gi = entry[0].split(/[|]/)[1].to_i
        @acc = entry[0].split(/[|]/)[3] 
        
        entry.drop(1).each {|el| @seq += el}
        @seq        
      end
      
    end
  end
end

