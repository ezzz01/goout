class CustomLogger < Logger
 def format_message(severity, timestamp, progname, msg)
    "#{timestamp.to_formatted_s(:db)} #{msg}\n" 
  end 

  def self.wikilog
    @@logfile ||= File.open(File.dirname(__FILE__) + "/../../log/wikilog.log", 'a')    
    @@logfile.sync = true
    self.new(@@logfile)
  end


  def self.last_entries
    @@logfile = File.open(File.dirname(__FILE__) + "/../../log/wikilog.log", 'r')    
#   @@logfile.seek(-300, IO::SEEK_END)
    @@logfile.readlines[-5..-1]
  end
end
