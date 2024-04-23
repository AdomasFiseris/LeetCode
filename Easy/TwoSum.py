class Solution(object):
    def twoSum(self, nums, target):
        """
        :type nums: List[int]
        :type target: int
        :rtype: List[int]
        """
        nums_dict = {}

        for index, num in enumerate(nums):
            complement = target - num
            if complement in nums_dict:
                return [nums_dict[complement], index]
            nums_dict[num] = index

        return []

solution = Solution()
nums = [2,7,11,15]
target = 9
result = solution.twoSum(nums, target)
print(result)
