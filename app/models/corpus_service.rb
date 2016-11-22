class CorpusService
  CORPUS = {}

  def self.add(words)
    words.each { |word| CORPUS[word] = [] }
  end
end
