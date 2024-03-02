class Solution(object):
    def spiralOrder(self, matrix):
        """
        :type matrix: List[List[int]]
        :rtype: List[int]
        """
        spiral = []
        if not matrix or not matrix[0]:
            return spiral

        left, right = 0, len(matrix[0])
        top, bottom = 0, len(matrix)

        while left < right and top < bottom:

            for i in range(left, right):
                spiral.append(matrix[top][i])
            top += 1
            
            for i in range(top, bottom):
                spiral.append(matrix[i][right - 1])
            right -= 1

            if not (left < right and top < bottom):
                break

            for i in range(right - 1, left - 1, -1):
                spiral.append(matrix[bottom - 1][i])
            bottom -= 1

            for i in range(bottom - 1, top - 1, -1):
                spiral.append(matrix[i][left])
            left += 1

        return spiral
        