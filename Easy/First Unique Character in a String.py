from collections import Counter


class Solution(object):
    def firstUniqChar(self, s):
        """
        :type s: str
        :rtype: int
        """
        counter_s = Counter(s)
        min_index = float('inf')

        for char, count in counter_s.items():
            if count == 1:
                min_index = min(min_index, s.index(char))

        return -1 if min_index == float('inf') else min_index