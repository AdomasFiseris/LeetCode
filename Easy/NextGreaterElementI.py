class Solution(object):
    def nextGreaterElement(self, nums1, nums2):
        """
        :type nums1: List[int]
        :type nums2: List[int]
        :rtype: List[int]
        """
        ans = []

        for i in nums1:
            index_in_nums2 = nums2.index(i)
            next_greater = -1

            for j in range(index_in_nums2 + 1, len(nums2)):
                if nums2[j] > i:
                    next_greater = nums2[j]
                    break

            ans.append(next_greater)

        return ans