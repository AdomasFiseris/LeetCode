class Solution(object):
    def countAndSay(self, n):
        """
        :type n: int
        :rtype: str
        """
        if n == 1:
            return "1"

        prev_term = "1"

        for _ in range(2, n + 1):
            new_term = ""
            i = 0
            while i < len(prev_term):
                count = 1

                while i + 1 < len(prev_term) and prev_term[i] == prev_term[i + 1]:
                    i += 1
                    count += 1

                new_term += str(count) + prev_term[i]
                i += 1
            
            prev_term = new_term
        
        return prev_term
        