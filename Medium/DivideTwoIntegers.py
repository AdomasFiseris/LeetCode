class Solution(object):
    def divide(self, dividend, divisor):
        """
        :type dividend: int
        :type divisor: int
        :rtype: int
        """
        if divisor == 0:
            raise ValueError("Divisor cannot be zero")
        if dividend == -2**31 and divisor == -1:
            return 2**31 - 1

        a, b = abs(dividend), abs(divisor)
        result = 0

        while a >= b:

            shift = 0
            while a >= (b << shift):
                shift += 1
            
            result += 1 << (shift - 1)
            a -= b << (shift - 1)

        if (dividend < 0) != (divisor < 0):
            result = -result

        return result
