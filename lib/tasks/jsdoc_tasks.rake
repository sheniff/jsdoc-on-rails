def parseAttr(attrib, val)

end

def parseFile(file, debug)
  #Creating or updating section
  filename = File.basename(str).split(".js")[0]
  sectionDB = Section.find_or_create_by_name(filename)
  functionDB = nil

  lines = File.open(file).readlines
  block = nil
  desc = true
  description = ""

  regex_iniblock = /^ *\/\*(!|\*){1}/
  regex_secblock = /^ *\/\*!/
  regex_endblock = /^ *\*\//
  regex_infoline = /^[^@]*@([^ ]*) *(.*)$/
  regex_descline = /^ *\*(.*)$/

  lines.each do |line|
    if line =~ regex_iniblock
      puts "Starting a block" if debug
      desc = true
      description = ""

      if line =~ regex_secblock
        block = 'sec'
      else
        block = 'fun'
        functionDB = Function.new

    elsif line =~ regex_endblock
      puts "Ending block!!" if debug
      block = false

      if(block == 'fun')
        nameAndStoreFun(lines[index+1], functionDB)
      return 1
    elsif block
      if b = regex_infoline.match(line)
        if desc
          puts "Description finished: " if debug
          desc = false
          (block == 'sec') ? sectionDB.update_column(:description, description) : functionDB.update_column(:description, description)
          puts description if debug
        else
          puts "parsing " + b[0] if debug
          (block == 'sec') ? parseSectionAttr(b[1], b[2], sectionDB) : parseFunctionAttr(b[1], b[2], functionDB)
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
