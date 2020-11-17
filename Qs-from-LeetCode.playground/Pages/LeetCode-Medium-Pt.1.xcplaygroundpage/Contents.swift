//: [Previous](@previous)

import Foundation

/*
 451. Sort Characters By Frequency
 Medium
 
 Given a string, sort it in decreasing order based on the frequency of characters.
 
 Example 1:
 
 Input:
 "tree"
 
 Output:
 "eert"
 
 Explanation:
 'e' appears twice while 'r' and 't' both appear once.
 So 'e' must appear before both 'r' and 't'. Therefore "eetr" is also a valid answer.
 Example 2:
 
 Input:
 "cccaaa"
 
 Output:
 "cccaaa"
 
 Explanation:
 Both 'c' and 'a' appear three times, so "aaaccc" is also a valid answer.
 Note that "cacaca" is incorrect, as the same characters must be together.
 Example 3:
 
 Input:
 "Aabb"
 
 Output:
 "bbAa"
 
 Explanation:
 "bbaA" is also a valid answer, but "Aabb" is incorrect.
 Note that 'A' and 'a' are treated as two different characters.
 */

func frequencySort(_ s: String) -> String {
    var occDict = [Character:Int]()
    let sArr = Array(s)
    for char in sArr {
        if occDict[char] == nil {
            occDict[char] = 1
        } else {
            occDict[char]! += 1
        }
    }
    let sortedDict = occDict.sorted { $0.value > $1.value }
    var resultArr = [String]()
    for (key,val) in sortedDict {
        var valNum = val
        while valNum > 0 {
            resultArr.append(String(key))
            valNum -= 1
        }
        
    }
    return resultArr.joined()
}

frequencySort("Aabb")

//====================================================================================

/*
 Given a binary tree, return the sum of values of nodes with even-valued grandparent.  (A grandparent of a node is the parent of its parent, if it exists.)
 
 If there are no nodes with an even-valued grandparent, return 0.
 
 Input: root = [6,7,8,2,7,1,3,9,null,1,4,null,null,null,5]
 Output: 18
 Explanation: The red nodes are the nodes with even-value grandparent while the blue nodes are the even-value grandparents.
 
 
 Constraints:
 
 The number of nodes in the tree is between 1 and 10^4.
 The value of nodes is between 1 and 100.
 */

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}

func sumEvenGrandparent(_ root: TreeNode?) -> Int {
    var sum = 0
    
    func dfs(_ root: TreeNode?, _ parent: TreeNode?, _ gParent: TreeNode?) {
        guard let node = root else { return }
        
        if let gp = gParent, gp.val % 2 == 0 { sum += node.val }
        
        dfs(node.left, node, parent)
        dfs(node.right, node, parent)
    }
    
    dfs(root, nil, nil)
    
    return sum
}

let rootNode = TreeNode(6, TreeNode(7, TreeNode(2, TreeNode(9, nil, nil), nil), TreeNode(7, TreeNode(1, nil, nil), TreeNode(4, nil, nil))), TreeNode(8, TreeNode(1, nil, nil), TreeNode(3, nil, TreeNode(5, nil, nil))))

sumEvenGrandparent(rootNode)

//================================================================================

/*
 442. Find All Duplicates in an Array
 Medium

 Given an array of integers, 1 ≤ a[i] ≤ n (n = size of array), some elements appear twice and others appear once.

 Find all the elements that appear twice in this array.

 Could you do it without extra space and in O(n) runtime?

 Example:
 Input:
 [4,3,2,7,8,2,3,1]

 Output:
 [2,3]
 */

func findDuplicates(_ nums: [Int]) -> [Int] {

    var occDict = [Int:Int]()
    var resultArr = [Int]()
    for num in nums {
        if occDict[num] == nil {
            occDict[num] = 1
        } else {
            resultArr.append(num)
        }
    }
    return resultArr
}

findDuplicates([4,3,2,7,8,2,3,1])

//==============================================================================

/*
 912. Sort an Array
 Medium

 Given an array of integers nums, sort the array in ascending order.

 Example 1:

 Input: nums = [5,2,3,1]
 Output: [1,2,3,5]
 Example 2:

 Input: nums = [5,1,1,2,0,0]
 Output: [0,0,1,1,2,5]
 */

func sortArray(_ nums: [Int]) -> [Int] {
        var varArr = nums
    quicksortLomuto(&varArr, low: 0, high: varArr.count - 1)
    return varArr
}

func lomutoPartition(_ arr: inout [Int], low: Int, high: Int) -> Int {
    
    let pivot = arr[high]
    var i = low
    
    // iterate through the array using j variable as our marker
    
    for j in low..<high {
        if arr[j] <= pivot {
            // swap and increment i
            arr.swapAt(i, j)
            i += 1
        }
    }
    arr.swapAt(i, high)
    return i
}

func quicksortLomuto(_ arr: inout [Int], low: Int, high: Int) {
    if low < high {
        // get a new pivot
        let pivot = lomutoPartition(&arr, low: low, high: high)
        // recursive calls
        // left array
        quicksortLomuto(&arr, low: low, high: pivot - 1)
        // right array
        quicksortLomuto(&arr, low: pivot + 1, high: high)
    }
}

sortArray([4,2,6,7,84,3,2,5])
