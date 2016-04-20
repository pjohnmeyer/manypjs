require 'json'
require 'commonmarker'

require_relative './post.rb'
require_relative './document.rb'

def prompt(p)
  print p + ' '
  input = STDIN.gets
  input.strip
end

def prompt_for_missing_metadata(meta)
  meta['category'] ||= prompt 'Enter a category for this post:'

  meta
end

# namespace :templates do

#   FileList['templates/*.md'].each { |md| task :erb => }

# end

def build_post(file)
  article = Post.new(file)
  html_doc = Document.from_page(article)
  File.write("public/posts/#{File.basename(file, '.md')}.html", html_doc)
  FileUtils.cp(file, 'public/posts/raw')
end

namespace :post do
  desc 'Build a post'
  task :build, [:src] do |_t, args|
    raw_post_file = args[:src]
    puts "Building #{raw_post_file}"

    meta_file = "#{raw_post_file}.meta"

    metadata = if File.exist? meta_file
                 JSON.parse(File.read(meta_file))
               else
                 {}
               end

    metadata = prompt_for_missing_metadata(metadata)
    build_post(raw_post_file)
    File.write(meta_file, JSON.unparse(metadata))
  end
end

# At some point, revision tracking =
# git log --format="%aI" bc78df444d19d66587dc7533b086539ce96ae10c^..HEAD
#    posts/raw/testing.md
# 2016-03-03T01:09:21-06:00
# 2016-03-03T01:04:35-06:00


FileList['posts/raw/*.md'].each do |src|
  task 'site:build' => "post:build[#{src}]"
end

namespace :site do
  desc 'Build the site'

  task :build do

  end
end
