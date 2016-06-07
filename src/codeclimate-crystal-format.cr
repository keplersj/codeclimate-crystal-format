require "compiler/crystal/formatter"
require "json"

Dir.glob("**/*.cr") do |file|
  original = File.read_lines(file).join
  fixed = Crystal.format(original, file)
  unless original == fixed
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
    puts issue.to_json
  end
end

# Ensure we exit with exit code 0 for CodeClimate
exit 0
