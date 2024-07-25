class Solution(object):
    def reverseWords(self, s):
        """
        :type s: str
        :rtype: str
        """
        s = s.strip()
        word_list = s.split()
        word_list_reversed = list(reversed(word_list))
        
        return " ".join(word_list_reversed)
