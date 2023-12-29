class Solution(object):
    def longestPalindrome(self, s):
        """
        :type s: str
        :rtype: int
        """
        char_count = {}

        for char in s:
            char_count[char] = char_count.get(char, 0) + 1

        palindrome_length = 0
        has_odd_count = False

        for count in char_count.values():
            palindrome_length += count // 2 * 2
            if count % 2 == 1:
                has_odd_count = True
        
        if has_odd_count:
            palindrome_length += 1

        return palindrome_length