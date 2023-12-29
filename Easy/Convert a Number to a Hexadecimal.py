class Solution(object):
    def toHex(self, num):
        """
        :type num: int
        :rtype: str
        """
        if num == 0:
            return "0"

        hex_chars = "0123456789abcdef"
        result = ""

        is_negative = False
        if num < 0:
            is_negative = True
            num = (1 << 32) + num

        while num > 0:
            remainder = num % 16
            result = hex_chars[remainder] + result
            num //= 16

        if is_negative:
            result

        return result