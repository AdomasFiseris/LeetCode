class Solution(object):
    def myAtoi(self, s):
        """
        :type s: str
        :rtype: int
        """
        s = s.strip()
        if not s:
            return 0

        sign = -1 if s[0] == "-" else 1
        digit = "0123456789"

        digits = []

        if s[0] in ("-", "+"):
            s = s[1:]

        for i in s:
            if i in digit:
                digits.append(i)
            else:
                break

        if not digits:
            return 0

        number_str = "".join(digits)
        number_str = int(number_str) * sign

        INT_MAX = 2**31 - 1
        INT_MIN = -2**31
        
        return min(max(number_str, INT_MIN), INT_MAX)
