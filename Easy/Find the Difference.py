class Solution(object):
    def findTheDifference(self, s, t):
        """
        :type s: str
        :type t: str
        :rtype: str
        """
        counter_s = Counter(s)
        counter_t = Counter(t)

        for char, count in counter_t.items():
            if char in counter_s:
                counter_t[char] -= counter_s[char]
            else:
                return char
                
        for char, count in counter_t.items():
            if count > 0:
                return char

        return None