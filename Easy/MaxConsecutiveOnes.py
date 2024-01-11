class Solution(object):
    def findMaxConsecutiveOnes(self, nums):
        """
        :type nums: List[int]
        :rtype: int
        """

        current_streak = []
        largest_streak = []

        for num in nums:
            if num == 1:
                current_streak.append(num)
            else:
                if len(current_streak) > len(largest_streak):
                    largest_streak = current_streak
                current_streak = []

        if len(current_streak) > len(largest_streak):
            largest_streak = current_streak

        return len(largest_streak)