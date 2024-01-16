class Solution(object):
    def findWords(self, words):
        """
        :type words: List[str]
        :rtype: List[str]
        """
        first_row = set("qwertyuiop")
        second_row = set("asdfghjkl")
        third_row = set("zxcvbnm")
        word_list = []

        for word in words:
            if all(letter.lower() in first_row for letter in word):
                word_list.append(word)
            if all(letter.lower() in second_row for letter in word):
                word_list.append(word)
            if all(letter.lower() in third_row for letter in word):
                word_list.append(word)

        return word_list
