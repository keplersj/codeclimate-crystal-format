require "compiler/crystal/formatter"
require "json"

def check_format(file)
  original = File.read(file)
  fixed = Crystal.format(original, file)
  unless original == fixed
    #STDERR.json_object do |object|
      # object.field "type", "issue"
      # object.field "check_name", "Crystal Format/Style"
      # object.field "description", "The Crystal Format tool found issue with your code."
    #end
    issue = {
      :type => "issue",
      :check_name => "Crystal Format/Style",
      :description => "The Crystal Format tool found issue with your code.",
      :categories => ["Style"],
      :location => {
        :path => file,
        :lines => {
          :begin => 1,
          :end => 1
        }
      }
    }
    STDOUT.puts issue.to_json
  end
end

engine_config = if File.exists?("/config.json")
  JSON.parse(File.read("/config.json"))
else
  {"include_paths" => ["."]}
end

engine_config["include_paths"].each do |path|
  path = path.to_s
  if File.directory?(path)
    Dir.glob("#{path}/**/*.cr") do |file|
      check_format file
    end
  elsif File.extname(path) == ".cr"
    check_format path
  end
end

# print <<-JSON
# {
#   "type": "issue",
#   "check_name": "Crystal Format/Style",
#   "description": "The Crystal Format tool found issue with your code.",
#   "categories": ["Style"],
#   "location": {
#     "path": "./src/bad-code.cr",
#     "lines": {
#       "begin": 1,
#       "end": 1
#     }
#   }
# }
# JSON

# Ensure we exit with exit code 0 for CodeClimate
# exit 0
