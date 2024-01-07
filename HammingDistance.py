class Solution(object):
    def hammingDistance(self, x, y):
        """
        :type x: int
        :type y: int
        :rtype: int
        """
        x_bin = bin(x)[2:]
        y_bin = bin(y)[2:]

        max_len = max(len(x_bin), len(y_bin))

        x_bin = x_bin.zfill(max_len)
        y_bin = y_bin.zfill(max_len)

        distance = sum(bit_x != bit_y for bit_x, bit_y in zip(x_bin, y_bin))

        return distance

solution = Solution()
distance = solution.hammingDistance(1, 4)
print(distance)