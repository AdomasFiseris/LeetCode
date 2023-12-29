class TreeNode(object):
    def __init__(self, val=0, left=None, right=None):
        self.val = val
        self.left = left
        self.right = right

class Solution(object):
    def sumOfLeftLeaves(self, root):
        total_sum = [0]

        def isLeaf(node):
            return node is not None and node.left is None and node.right is None

        def traverse(node):
            if node is None:
                return

            if node.left and isLeaf(node.left):
                total_sum[0] += node.left.val

            traverse(node.left)
            traverse(node.right)

        traverse(root)
        return total_sum[0]

# Creating a binary tree
#     3
#    / \
#   9  20
#      / \
#     15  7

root = TreeNode(3)
root.left = TreeNode(9)
root.right = TreeNode(20)
root.right.left = TreeNode(15)
root.right.right = TreeNode(7)

solution_instance = Solution()
total_sum = solution_instance.sumOfLeftLeaves(root)
print(total_sum)
