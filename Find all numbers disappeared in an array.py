class Solution(object):
    def findDisappearedNumbers(self, nums):
        """
        :type nums: List[int]
        :rtype: List[int]
        """
        set_nums = set(nums)
        all_nums = set(range(1, len(nums) + 1))

        dissapeared_numbers = all_nums - set_nums
        
        return dissapeared_numbers
