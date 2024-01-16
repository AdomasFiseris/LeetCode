# Definition for a binary tree node.
# class TreeNode(object):
#     def __init__(self, val=0, left=None, right=None):
#         self.val = val
#         self.left = left
#         self.right = right
class Solution(object):
    def findMode(self, root):
        """
        :type root: TreeNode
        :rtype: List[int]
        """
        def in_order_traversal(node, count_dict):
            if node:
                in_order_traversal(node.left, count_dict)
                count_dict[node.val] = count_dict.get(node.val, 0) + 1
                in_order_traversal(node.right, count_dict)

        count_dict = {}
        in_order_traversal(root, count_dict)

        max_count = max(count_dict.values() or [0])
        mode_values = [key for key, value in count_dict.items() if value == max_count]

        return mode_values
