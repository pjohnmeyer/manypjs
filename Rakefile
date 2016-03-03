require 'json'
require 'commonmarker'

namespace :post do
  task :build, [:src] do |_t, args|

    puts "Building #{args[:src]}"

    meta_file = "#{args[:src]}.meta"

    if (!File.exist?(meta_file))
      metadata = {
        'first_published' => nil
      }
    else 
      metadata = JSON.parse(File.read(meta_file))
    end

    html = CommonMarker.render_html(File.read(args[:src]))
    File.write('posts/testing.html', html)
    File.write(meta_file, JSON.unparse(metadata))
  end 
end


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