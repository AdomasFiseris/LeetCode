class Solution(object):
    def constructRectangle(self, area):
        """
        :type area: int
        :rtype: List[int]
        """
        L, W = 0, 0

        sqrt_area = int(area ** 0.5)

        for W in range(sqrt_area, 0, -1):
            if area % W == 0:
                L = area // W
                if L >= W:
                    return [L, W]

        return [L, W]
