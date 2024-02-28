class Solution(object):
    def permuteUnique(self, nums):
        """
        :type nums: List[int]
        :rtype: List[List[int]]
        """
        if len(nums) <= 1:
            return [nums]

        else:
            perms = set()

            for i in range(len(nums)):

                current_element = nums[i]
                remaining_list = nums[:i] + nums[i + 1:]

                for j in self.permuteUnique(remaining_list):

                    perms.add((current_element,) + tuple(j))

        return [list(p) for p in perms]
