class CorpusService
  CORPUS = {}

  def self.create_dictionary
    @dictionary ||= unzip_dictionary
  end

  def self.add(words)
    words.each { |word| find_anagrams(word) }
  end

  def self.anagrams(word)
    {
      anagrams: CORPUS[word] || []
    }
  end

  private

    def self.unzip_dictionary
      zip_dictionary = File.open("#{Rails.root}/dictionary.txt.gz")
      Zlib::GzipReader.new(zip_dictionary).read.split("\n")
    end

    def self.find_anagrams(word)
      return if CORPUS.has_key?(word)

      CORPUS[word] = []
      @dictionary.each { |dictionary_word| CORPUS[word] << compare_words(word, dictionary_word) }
      CORPUS[word].reject! { |w| w == word }.uniq!.compact!
    end

    def self.compare_words(word1, word2)
      sorted_word1 = word1.downcase.chars.sort.join
      sorted_word2 = word2.downcase.chars.sort.join
      word2 if sorted_word1 == sorted_word2
    end

end
