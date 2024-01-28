class Solution(object):
    def letterCombinations(self, digits):
        """
        :type digits: str
        :rtype: List[str]
        """

        def backtrack(index, current_combination):

            if index == len(digits):
                result.append(current_combination)
                return
            
            current_digit = digits[index]
            possible_letters = letters[current_digit]

            for letter in possible_letters:
                backtrack(index + 1, current_combination + letter)

        if not digits:
            return []

        letters = {
            "2": "abc", "3": "def", "4": "ghi", "5": "jkl", "6": "mno",
            "7": "pqrs", "8": "tuv", "9": "wxyz"
        }

        result = []
        backtrack(0, "")

        return result