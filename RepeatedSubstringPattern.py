class Solution(object):
    def repeatedSubstringPattern(self, s):
        """
        :type s: str
        :rtype: bool
        """
        s_len = len(s)

        for i in range(1, s_len // 2 + 1):
            if s_len % 2 == 0:
                substring = s[:i]
                pattern = substring * (s_len // i)

                if pattern == s:
                    return True
            
        return False