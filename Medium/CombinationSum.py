class Solution(object):
    def combinationSum(self, candidates, target):
        """
        :type candidates: List[int]
        :type target: int
        :rtype: List[List[int]]
        """
        result = []
        
        def backtrack(start, combination, current_sum):

            if current_sum == target:
                result.append(list(combination))
            if current_sum > target:
                return

            for i in range(start, len(candidates)):

                combination.append(candidates[i])
                backtrack(i, combination, current_sum + candidates[i])
                combination.pop()
        
        backtrack(0, [], 0)
        return result
    