class Solution(object):
    def findPoisonedDuration(self, timeSeries, duration):
        """
        :type timeSeries: List[int]
        :type duration: int
        :rtype: int
        """
        count = 0

        for i in range(len(timeSeries) - 1):
            count += min(duration, timeSeries[i + 1] - timeSeries[i])

        count += duration

        return count