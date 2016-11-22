class CorpusServiceTest < Minitest::Test
  def test_unzip_dictionary_file_with_correct_count_of_words
    dictionary = CorpusService.unzip_dictionary

    assert_equal 235886, dictionary.count
  end

  def test_creates_a_dictionary
    dictionary = CorpusService.create_dictionary

    assert_equal 235886, dictionary.count
  end

  def test_add_anagram_words_to_corpus
    CorpusService.create_dictionary
    words = %w(read write add)
    CorpusService.add(words)
    read_anagram_words = CorpusService.anagrams('read')
    expected_result    = { anagrams:  ["ared", "daer", "dare", "dear"] }

    assert_equal expected_result, read_anagram_words
  end

  def test_anagrams_returns_empty_array_if_word_is_not_found_in_corpus
    expected = { anagrams: [] }
    result   = CorpusService.anagrams('read')

    assert_equal expected, result
  end

end
