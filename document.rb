class Document

  def self.from_page(page)
"""
<!DOCTYPE html>
<html>

<head>
  <title>
    #{page.title}
  </title>
</head>

<body>
  <#{page.content_type}>
    #{page.content}
  </#{page.content_type}>
</body>

</html>
"""
  end

end

# require 'minitest/autorun'

# class TestDocument < Minitest::Test
#   def test_works_with_post
#     require_relative './post.rb'
#     post = Post.new('examples/simple_post.md')
#     Document.from_page(post)
#   end
# end
