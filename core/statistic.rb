require_relative "database"

class Statistic
  attr_reader :title

  def query
    raise "Must implement #query"
  end

  def transform(query_results)
    query_results.each(as: :array)
  end

  def data
    query_results = Database.client.query(query)
    @data ||= transform(query_results)
  end

  def top
    markdown = "## #{@title}\n\n"
    markdown += "*Note: #{@note}*\n" if @note
    markdown + Time.now.strftime("*Computed on %e %B %Y*\n\n")
  end

  def markdown
    top + markdown_table(@table_header, data)
  end

  def markdown_table(header, data)
    table = "| #{header.keys.join(' | ')} |\n"
    alignments = { left: ":---", center: ":--:", right: "---:" }
    table += "| #{header.values.map { |alignment| alignments[alignment] }.join(' | ')} |\n"
    data.each do |row|
      table += "| #{row.join(' | ')} |\n"
    end
    table
  end
end
