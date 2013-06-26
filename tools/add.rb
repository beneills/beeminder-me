#!/usr/bin/env ruby

require "highline/import"
require "open-uri"

profile_url = ARGV.first
person_short_name = profile_url.split( "/" )[-1]

body = open(profile_url).read

goals = body.scan(/\/goals\/([\w-]+)/).uniq.map { |g| g[0] }

# goals.each_with_index { |goal, id|
#   puts "<#{id}> #{goal[0]}"
# }

# id = ask( "Which goal? ", Integer ) { |q|
#   q.in = 0...goals.length
# }


puts "Choose goal:"
goal_name = choose( *goals )
person_full_name = ask( "Person's full name? " )
tags = ask( "Tags (separate with comma/space)? " ).split(/[ ,]+/).join( " " )
description = ask( "Description of goal? " )

description = ask( "Description of goal? " )
description = "&nbsp;" if description.nil?

goal_url = File.join( profile_url, "goals", goal_name)
goal_graph = File.join( goal_url, "/graph")

text = ""
File.open("post_template.markdown", "r") { |f|
  text = f.read
  text.gsub!(/\$DATE/, DateTime.now.strftime("%F %T"))
  text.gsub!(/\$PROFILE_URL/, profile_url)
  text.gsub!(/\$PERSON_FULL_NAME/, person_full_name)
  text.gsub!(/\$PERSON_SHORT_NAME/, person_short_name)
  text.gsub!(/\$TAGS/, tags)
  text.gsub!(/\$DESCRIPTION/, description)
  text.gsub!(/\$GOAL_NAME/, goal_name)
  text.gsub!(/\$GOAL_GRAPH/, goal_graph)
  text.gsub!(/\$GOAL_URL/, goal_url)
}

date = DateTime.now.strftime("%F")

# Taken from http://www.ruby-forum.com/topic/191831
def unique(filename)
  count = 0
  unique_name = filename
  while File.exists?(unique_name)
    count += 1
    unique_name = "#{File.join(
      File.dirname(filename),
      File.basename(filename, ".*"))}_#{count}#{File.extname(filename)}"
  end
  unique_name
end

filename = unique( File.expand_path( "../_posts/#{date}-#{person_short_name}.markdown") )

File.open(filename, "w") { |f|
  f.puts text
}


goal_text = "#{person_short_name}/#{goal_name}"


puts "Sucessfully added #{goal_text} to working directory"

`git checkout master`
`git add #{filename}`
`git commit -m "add.rb: added new goal '#{goal_text}'"`

puts "Sucessfully committed.  Now push!"
