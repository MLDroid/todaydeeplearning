namespace :arvix_papers do
  desc "Fetch and save latest cs.AI papers from Arvix"
  task :populate_with_latest_papers => :environment do
    raw_papers = ArvixGetter.new(max_results: 3).papers
    hashed = Hash.from_xml(raw_papers)
    entries = hashed["feed"]["entry"]

    entries.each do |entry|
      ArvixPaper::Create.new(entry).call
    end
  end

  desc "Fetch and save latest papers from all categories Arvix"
  task :populate_with_various_papers => :environment do
    categories = ['cs.CV', 'cs.CL', 'cs.LG', 'cs.AI', 'cs.NE', 'stat.ML']
    categories.each do |cat|
      raw_papers = ArvixGetter.new(max_results: 100, cat: cat).papers
      hashed = Hash.from_xml(raw_papers)
      entries = hashed["feed"]["entry"]

      entries.each do |entry|
        ArvixPaper::Create.new(entry).call
      end
    end
  end
end
