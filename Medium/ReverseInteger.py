class Solution(object):
    def reverse(self, x):
        """
        :type x: int
        :rtype: int
        """
        sign = -1 if x < 0 else 1
        x_str = str(abs(x))

        reversed_x = int(x_str[::-1]) * sign

        INT_MAX = 2**31 - 1
        INT_MIN = -2**31
        
        if reversed_x > INT_MAX or reversed_x < INT_MIN:
            return 0

        return reversed_x