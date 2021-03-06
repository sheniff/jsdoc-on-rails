def parseSectionAttr(attrib, val, section)
  sa = JsdocSectionAttribute.new(name: attrib, description: val)
  sa.jsdoc_section = section
  sa.save!
end

def parseFunctionAttr(attrib, val, function)
  split_param = /^(?:{(.*)})?\s*(.*)/.match(val)
  fa = JsdocFunctionAttribute.new(name: attrib, param: split_param[1], description: split_param[2])
  fa.jsdoc_function = function
  fa.save!
end

def nameAndStoreFunction(head, function)
  if head.is_a?(String)
    function.name = head
    createOrUpdateFunction(function)
  elsif head.is_a?(Array)
    head.each do |fname|
      new_func = function.dup
      new_func.name = fname
      createOrUpdateFunction(new_func)
    end
    function.destroy #Destroying original, as we have one for each copy
  else
    function.destroy
  end
end

def createOrUpdateFunction(function)
  # Keeping manually created info :)
  functionDB = JsdocFunction.find_by_name_and_jsdoc_section_id(function.name,function.jsdoc_section_id)
  if functionDB
    function.content = functionDB.content
    functionDB.delete
  end
  function.save
end

def arraify(str)
  str.gsub(/["' ]/,"").split(",") if str
end

def findHeaderLine(lines, start, debug)
  puts "Looking for function header" if debug
  # ignore empty lines
  while lines[start] && lines[start] =~ /^\s*$/
    start += 1
  end

  return false if not lines[start]

  puts "Found function header line: " + lines[start] if debug
  puts "Extracting function name..." if debug
  regex_function_name = /^\s*(?:(?:(?:var )?\s*)([$.\w]+).*[=:])(?:.*function)|each\(\[(.*)\].*function/
  fname = regex_function_name.match(lines[start])
  puts fname if debug

  return false if not fname

  if fname[1]
    funcname = fname[1]
  else
    funcname = arraify(fname[2])
  end

  puts funcname if debug
  return funcname
end

def parseFile(file, debug)
  #Creating or updating section
  filename = File.basename(file).split(".js")[0]
  sectionDB = JsdocSection.find_or_create_by_name(filename)
  functionDB = nil

  #Cleaning the section attributes (as we are creating new ones)
  sectionDB.jsdoc_section_attributes.destroy_all

  lines = File.open(file).readlines
  block = nil
  desc = true
  description = ""

  regex_iniblock = /^\s*\/\*(!|\*){1}/
  regex_secblock = /^\s*\/\*!/
  regex_endblock = /^\s*\*\//
  regex_infoline = /^[^@]*@([^\s]*)\s*(.*)$/
  regex_descline = /^\s*\*(.*)$/

  lines.each_with_index do |line, index|
    if line =~ regex_iniblock
      puts "**** Starting a block" if debug
      desc = true
      description = ""

      if line =~ regex_secblock
        block = 'sec'
      else
        block = 'fun'
        functionDB = JsdocFunction.new
        functionDB.jsdoc_section = sectionDB
      end

    elsif line =~ regex_endblock
      puts "**** Ending block" if debug
      nameAndStoreFunction(findHeaderLine(lines, index+1, debug), functionDB) if block == 'fun'
      block = false

    elsif block
      if b = regex_infoline.match(line)
        if desc
          puts "Description finished: " if debug
          desc = false
          (block == 'sec') ? sectionDB.update_column(:description, description) : functionDB.description = description
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
  task :generate => :environment do
    src = ENV['SRC']
    debug = ENV['DEBUG']

    if src.blank?
      puts "SRC with javascript files not provided, please write 'rake jsdoc:generate SRC=route/to/my/js'"
      return 1
    end

    if debug
      debug = debug.downcase == 'true'
    end

    generateDoc(src, debug)
    puts " * Doc generated and stored in JSDoc_* DB tables"
  end
end
