#!/usr/bin/env ruby

require "highline/import"
require "open-uri"


profile_url = "https://www.beeminder.com/beneills"


person_short_name = profile_url.split( "/" )[-1]
body = open(profile_url).read
goals = body.split(/<div class=\"archive\">/)[0]
  .scan(/\/goals\/([\w-]+)/).uniq.map { |g| g[0] }

for goal_name in goals
  next if !Dir.glob("../_posts/*-#{goal_name}.markdown").empty? # allows manual ordering by date change

  filename = File.expand_path( "../_posts/1066-01-01-#{goal_name}.markdown")
  description = "&nbsp;" # Default to nothing; change manually
  goal_url = File.join( profile_url, "goals", goal_name)
  goal_graph = File.join( goal_url, "/graph")

  text = ""
  File.open("post_template.markdown", "r") { |f|
    text = f.read
    text.gsub!(/\$DATE/, DateTime.now.strftime("%F %T"))
    text.gsub!(/\$PROFILE_URL/, profile_url)
    text.gsub!(/\$DESCRIPTION/, description)
    text.gsub!(/\$GOAL_NAME/, goal_name)
    text.gsub!(/\$GOAL_GRAPH/, goal_graph)
    text.gsub!(/\$GOAL_URL/, goal_url)
  }
  
  File.open(filename, "w") { |f|
    f.puts text
  }
  
  
  goal_text = "#{person_short_name}/#{goal_name}"
  puts "Sucessfully added #{goal_text} to working directory"
  
  `git checkout master`
  `git add #{filename}`
  `git commit -m "update.rb: added new goal '#{goal_text}'"`
end

puts "Sucessfully committed.  Now push!"
  
