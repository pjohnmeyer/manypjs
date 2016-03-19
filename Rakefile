require 'json'
require 'commonmarker'

def prompt(p)
  print p + ' '
  input = STDIN.gets
  input.strip
end

def prompt_for_missing_metadata(meta)

  meta['category'] ||= prompt 'Enter a category for this post:'

  meta

end

namespace :post do
  task :build, [:src] do |_t, args|

    puts "Building #{args[:src]}"

    meta_file = "#{args[:src]}.meta"

    if (!File.exist?(meta_file))
      metadata = {
      }
    else
      metadata = JSON.parse(File.read(meta_file))
    end

    metadata = prompt_for_missing_metadata(metadata)

    html = CommonMarker.render_html(File.read(args[:src]))
    File.write('public/posts/testing.html', html)
    FileUtils.cp(args[:src], 'public/posts/raw')
    File.write(meta_file, JSON.unparse(metadata))
  end

end

# At some point, revision tracking =
#git log --format="%aI" bc78df444d19d66587dc7533b086539ce96ae10c^..HEAD posts/raw/testing.md
# 2016-03-03T01:09:21-06:00
# 2016-03-03T01:04:35-06:00

namespace :site do

  desc 'Build the site'

  task :build do
    # For each raw post
      # build historic revisions
      # build 'draft' revision for local modifications


    Dir.glob('posts/raw/*.md') do |file|
      Rake::Task['post:build'].invoke(file)
    end
  end

end