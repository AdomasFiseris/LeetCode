class Solution(object):
    def duplicateZeros(self, arr):
        """
        :type arr: List[int]
        :rtype: None Do not return anything, modify arr in-place instead.
        """
        original_length = len(arr)
        zeros = arr.count(0)

        for i in range(original_length - 1, -1, -1):
            
            if i + zeros < original_length:
                arr[i + zeros] = arr[i]
            if arr[i] == 0:
                zeros -= 1
                if i + zeros < original_length:
                    arr[i + zeros] = 0
