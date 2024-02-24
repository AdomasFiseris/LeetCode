class Solution(object):
    def combinationSum2(self, candidates, target):
        """
        :type candidates: List[int]
        :type target: int
        :rtype: List[List[int]]
        """
        candidates.sort()
        result = []

        def backtrack(start, combination, current_sum):

            if current_sum == target:
                result.append(list(combination))
            if current_sum > target:
                return

            for i in range(start, len(candidates)):
                
                if i > start and candidates[i] == candidates[i-1]:
                    continue
                combination.append(candidates[i])
                backtrack(i + 1, combination, current_sum + candidates[i])
                combination.pop()

        backtrack(0, [], 0)
        return result
