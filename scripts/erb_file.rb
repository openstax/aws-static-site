require 'erb'

class ErbFile
  def initialize(directory, filename)
    @contents = File.open(File.join(directory, filename), "r").read
  end

  def bind(the_binding)
    ERB.new(@contents, nil, '-').result(the_binding)
  end
end

module ToYamlViaErb
  def to_yaml_via_erb(directory, filename, indent=0, variables={})
    the_binding = binding
    variables.each do |name, value|
      the_binding.local_variable_set(name, value)
    end
    ErbFile.new(directory, filename).bind(the_binding).indent(indent).lstrip
  end
end
