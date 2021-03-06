class ArvixParser
  def initialize(entry)
    @entry = entry
  end

  def parse
    if @entry.nil? || !@entry.is_a?(Hash) || @entry['title'].nil?
      p "Failed to parse #{@entry}"
      return
    end

    parsed = {
      title: @entry['title'],
      category: @entry['primary_category']["term"],
      summary: @entry['summary'],
      comment: @entry['comment'],
      paper_link: @entry['link'].find { |l| l['type'] == 'text/html' }['href'],
      pdf_link: @entry['link'].find { |l| l['type'] == 'application/pdf' }['href'] + '.pdf',
      published_date: DateTime.parse(@entry['published']),
      paper_updated_at: DateTime.parse(@entry['updated']),
      raw_data: @entry,
    }

    parsed
  end

  def author_names
    authors = @entry['author']
    if authors && authors.is_a?(Array)
      @entry['author'].map { |author| author['name'] }
    else
      []
    end
  end
end
