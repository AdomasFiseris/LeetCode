class Solution(object):
    def jump(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """
        jumps, farthest, currentEnd = 0, 0, 0
        n = len(nums)

        for i in range(n - 1):

            farthest = max(farthest, i + nums[i])

            if i == currentEnd:
                jumps += 1
                currentEnd = farthest

                if currentEnd >= n - 1:
                    break

        return jumps
    