class Solution(object):
    def canJump(self, nums):
        """
        :type nums: List[int]
        :rtype: bool
        """
        maxReach = 0

        for i, jump in enumerate(nums):

            if i > maxReach:
                return False
            
            maxReach = max(maxReach, i + jump)

            if maxReach >= len(nums) - 1:
                return True
        
        return True
        