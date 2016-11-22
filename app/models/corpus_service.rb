class CorpusService
  CORPUS = {}

  def self.create_dictionary
    @dictionary = unzip_dictionary
  end

  def self.add(words)
    words.each { |word| find_anagrams(word) }
  end

  private

    def self.unzip_dictionary
      zip_dictionary = File.open("#{Rails.root}/dictionary.txt.gz")
      gz             = Zlib::GzipReader.new(zip_dictionary)
      gz.read.split("\n")
    end

    def self.find_anagrams(word)
      CORPUS[word] = [] unless CORPUS[word]
      @dictionary.each { |dictionary_word| CORPUS[word] << compare_words(word, dictionary_word) }
      CORPUS[word].delete(word)
      CORPUS[word].uniq!.compact!
    end

    def self.compare_words(word1, word2)
      sorted_word1 = word1.downcase.chars.sort.join
      sorted_word2 = word2.downcase.chars.sort.join
      word2 if sorted_word1 == sorted_word2
    end

end
