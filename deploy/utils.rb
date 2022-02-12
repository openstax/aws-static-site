require 'forwardable'
require 'open3'
require 'active_support'
require 'active_support/core_ext'
require 'byebug'
require_relative 'config'

module Utils

  def run(command, quiet: false)
    puts "Running: #{command}" unless quiet

    output = []
    Open3.popen2e(command) do |stdin, stdout_err, wait_thr|
      stdout_err.sync = true

      while char = stdout_err.getc do
        output.push(char)
        STDERR.print char unless quiet
      end
    end

    output.join.chomp
  end

  def stack_name(template_file)
    _, filename = File.split(template_file)
    "static-site-#{Config.instance[:hyphen_site_name]}-#{filename.gsub('.yml','').downcase.gsub('_','-')}"
  end

  def get_stack_output(region:, template_file:, output_key:)
    run(%Q(aws cloudformation --region #{region} describe-stacks --stack-name #{stack_name(template_file)} --query "Stacks[0].Outputs[?OutputKey=='#{output_key}'].OutputValue" --output text), quiet: true)
  end

end
