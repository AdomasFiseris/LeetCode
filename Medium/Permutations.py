class Solution(object):
    def permute(self, nums):
        """
        :type nums: List[int]
        :rtype: List[List[int]]
        """
        if len(nums) <= 1:
            return [nums]

        else:
            perms = []

            for i in range(len(nums)):

                current_element = nums[i]
                remaining_list = nums[:i] + nums[i + 1:]

                for j in self.permute(remaining_list):
                    perms.append([current_element] + j)
        
        return perms
