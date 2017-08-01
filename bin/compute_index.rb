#!/usr/bin/env ruby

require_relative "../statistics/index"

# Generate statistics index.
build_path = File.expand_path("../build", __dir__)
list = STATISTICS.map { |statistics_id, statistic_object| "- [#{statistic_object.title}](#{statistics_id})\n" }.join
destination_path = File.join(build_path, "README.md")
File.write(destination_path, list)