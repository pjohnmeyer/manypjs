class Document

  def self.from_page(page)
<<-HTML
<!DOCTYPE html>
<html lang="en">

<head>
  <script type="text/javascript">
      var host = "www.manypjs.com";
      if ((host == window.location.host) && (window.location.protocol != "https:"))
          window.location.protocol = "https";
  </script>

  <meta charset="utf-8" />
  <link rel="canonical" href="https://www.manypjs.com/#{page.href}" />
  <title>
    Many PJs - #{page.title}
  </title>
</head>

<body>
  <#{page.content_type}>
    #{page.content}
  </#{page.content_type}>
</body>

</html>
HTML
  end

end

require 'minitest/autorun'

class TestDocument < Minitest::Test
  def test_works_with_post
    require_relative './post.rb'
    post = Post.new('examples/simple_post.md')
    Document.from_page(post)
  end
end
