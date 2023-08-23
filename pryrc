# switch default editor for pry to sublime text, remove this line to get :vim
Pry.config.editor = proc { |file, line| "code --wait --goto #{file}:#{line} --disable-workspace-trust" }

# Turn off paging (annoying and requires ‘q’ to get back to prompt
Pry.pager = false

# format prompt to be <Rails version>@<ruby version>(<object>)>
Pry.config.prompt = proc do |obj, level, _|
  prompt = "\e[1;30m"
  prompt << "#{Rails.version} @ " if defined?(Rails)
  prompt << "#{RUBY_VERSION}"
  "#{prompt} (#{obj})>\e[0m"
end

# output using awesome print
begin
  require 'awesome_print' 
  Pry.config.print = proc { |output, value| output.puts value.ai }
  AwesomePrint.pry!
rescue LoadError => err
  puts "no awesome_print :("
end
