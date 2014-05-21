class Writer
  
  # IN: full path to output location or nothing
  def initialize(format, outfile = nil)
    @file_handle = open_outfile(outfile) unless outfile.nil?
    @format = format
  end
  
  def write(obj)
    out_string = obj.to_format(@format)
    
    if @file_handle.nil?
      puts out_string
      
    else
      @file_handle.puts out_string
    end
  end
  
  private
  
  def open_outfile(ofile)
    begin
      fh = File.open(ofile, "w")
      return fh
    rescue
      raise ArgumentError, "Unable to open file #{ ofile } for writing."
    end
  end
end
