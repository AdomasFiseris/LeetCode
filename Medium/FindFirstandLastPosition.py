class Solution(object):
    def searchRange(self, nums, target):
        """
        :type nums: List[int]
        :type target: int
        :rtype: List[int]
        """
        def findFirst(nums, target):
            left, right = 0, len(nums) - 1

            while left <= right:
                mid = (left + right) // 2

                if nums[mid] >= target:
                    right = mid - 1
                else:
                    left = mid + 1
            return left

        def findLast(nums, target):
            left, right = 0, len(nums) - 1

            while left <= right:
                mid = (left + right) // 2

                if nums[mid] <= target:
                    left = mid + 1
                else:
                    right = mid - 1
            return right
        
        start = findFirst(nums, target)
        end = findLast(nums, target)

        if start <= end and start < len(nums) and nums[start] == target:
            return [start, end]
        else:
            return [-1, -1]          
                