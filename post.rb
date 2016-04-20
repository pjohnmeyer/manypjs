require 'commonmarker'

class Post

  attr_reader :title, :content, :content_type

  def initialize(filename)
    readable = File.open(filename)
    doc = CommonMarker.render_doc(readable.read)

    doc.walk do |node|
      if node.type == :header && node.header_level == 1 && @title.nil?
        node.walk do |subnode|
          @title ||= ''
          @title += subnode.string_content if subnode.type == :text
        end
      end
    end

    @content = doc.to_html
    @content_type = :article
  end

end

require 'minitest/autorun'

class TestPost < Minitest::Test

  def test_title
    post = Post.new('examples/simple_post.md')
    assert_equal "Post title", post.title
  end

  def test_body
    post = Post.new('examples/simple_post.md')
    pristine = begin File.read 'examples/simple_post.html.approved' rescue '' end
    File.write 'examples/simple_post.html.approved', post.content
    assert_equal pristine, post.content, 'simple_post output has changed, diff and commit to approve'
  end

end


