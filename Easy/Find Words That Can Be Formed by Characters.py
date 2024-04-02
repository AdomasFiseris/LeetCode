class Solution(object):
    def countCharacters(self, words, chars):
        """
        :type words: List[str]
        :type chars: str
        :rtype: int
        """
        def count_chars(s):
            char_count = {}
            for char in s:
                if char in char_count:
                    char_count[char] += 1
                else:
                    char_count[char] = 1
            return char_count
        
        chars_count = count_chars(chars)
        total_length = 0
        
        for word in words:
            word_count = count_chars(word)
            can_form_word = True
            for char, count in word_count.items():
                if char not in chars_count or chars_count[char] < count:
                    can_form_word = False
                    break
            if can_form_word:
                total_length += len(word)
                
        return total_length
    