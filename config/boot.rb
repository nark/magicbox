ENV['BUNDLE_GEMFILE'] ||= File.expand_path('../Gemfile', __dir__)

require 'bundler/setup' # Set up gems listed in the Gemfile.
unless File.exists?("/proc/cpuinfo") && (File.read("/proc/cpuinfo").include?("ARMv7") or File.read("/proc/cpuinfo").include?("ARMv6"))
  require 'bootsnap/setup'
end
