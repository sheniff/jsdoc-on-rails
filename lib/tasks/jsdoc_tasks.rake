def parseAttr(attrib, val)

end

def parseFile(file, debug)
  lines = File.open(file).readlines
  block = false
  desc = true
  description = ""

  regex_iniblock = /^ *\/\*(!|\*){1}/
  regex_endblock = /^ *\*\//
  regex_infoline = /^[^@]*@([^ ]*) *(.*)$/
  regex_descline = /^ *\*(.*)$/

  lines.each do |line|
    if line =~ regex_iniblock
      puts "Starting block!!" if debug
      desc = true
      description = ""
      block = true
    elsif line =~ regex_endblock
      puts "Ending block!!" if debug
      block = false
      return 1
    elsif block
      if b = regex_infoline.match(line)
        if desc
          desc = false
          puts "Description finished: " if debug
          puts description if debug
        else
          puts "parsing " + b[0] if debug
          parseAttr(b[1], b[2])
        end
      elsif desc
        d = regex_descline.match(line)[1]
        description += d + "\n" if d
      end
    end
  end
end

def generateDoc(dir, debug)
  require 'find'

  puts "Exploring dir: " + dir if debug

  Find.find(dir) do |path|
     if FileTest.directory?(path)
       next
     else
       puts "Scanning: " + path if debug
       parseFile(path, debug)
     end
   end

end

namespace :jsdoc do
  desc "Generate documentation from a given SRC"
  task :generate do
    src = ENV['SRC']
    debug = ENV['DEBUG'].downcase == 'true'

    if src.blank?
      puts "SRC with javascript files not provided, please write 'rake jsdoc:generate SRC=route/to/my/js'"
      return 1
    end

    generateDoc(src, debug)
  end
end
