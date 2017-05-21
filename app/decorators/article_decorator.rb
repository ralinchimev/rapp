class ArticleDecorator < SimpleDelegator
  def class
    __getobj__.class
  end

  def markdown
    markdown_renderer.render(content).html_safe
  end

  private

  def markdown_renderer
    Redcarpet::Markdown.new(MarkdownRenderer.new(markdown_options), markdown_extensions)
  end

  def markdown_options
    {
      filter_html: false,
      hard_wrap: true,
      no_styles: true,
      link_attributes: {rel: 'nofollow', target: '_blank'},
      prettify: true,
      safe_links_only: true,
    }
  end

  def markdown_extensions
    {
      fenced_code_blocks: true,
      footnotes: false,
      highlight: true,
      quote: true,
      space_after_headers: false,
    }
  end
end
