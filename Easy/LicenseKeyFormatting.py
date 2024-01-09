class Solution(object):
    def licenseKeyFormatting(self, s, k):
        """
        :type s: str
        :type k: int
        :rtype: str
        """
        s = s.replace("-", "")  
        s = s.upper()

        n = len(s)
        first_group_length = n % k if n % k != 0 else k

        license_key = [s[:first_group_length]]

        for i in range(first_group_length, n, k):
            license_key.append(s[i:i + k])

        return "-".join(license_key)
        