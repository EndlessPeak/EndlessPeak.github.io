---
title: STL
date: 2024-06-11
authors: 
    - EndlessPeak
toc: true
featuredImage: 
hidden: false
draft: false
weight: 2
description: 本文记录C++STL编程的相关知识。
---

## Vector
### Brief
`std::vector` 是 C++ 标准模板库(STL)中的一个动态数组类。它能够自动管理内存，在需要时自动扩展或收缩。`std::vector` 具有以下特点：
1. 动态大小：可以根据需要增加或减少元素的数量。
2. 连续内存：元素在内存中是连续存储的，支持高效的随机访问。
3. 自动扩展：在添加新元素时，`std::vector` 会自动扩展容量。

### Extend
当向 `std::vector` 添加新元素时，如果当前容量不足以容纳新元素，`std::vector` 会自动扩展其容量。扩展的过程如下：
1. 检测容量：检查当前容量是否足够容纳新元素。
2. 分配新内存：如果容量不足，`std::vector` 会分配一块更大的内存空间，通常是当前容量的两倍（具体倍数由实现决定）。
3. 复制元素：将现有元素从旧内存块复制到新内存块。
4. 释放旧内存：释放旧的内存块。

下面是一个例子演示在向 ~std::vector~ 中添加元素以触发动态扩展。
```cpp
#include <iostream>
#include <vector>

int main() {
    std::vector<int> vec;
    // vec.reserve(5);  // 预留初始容量（可选）

    std::cout << "Initial Capacity: " << vec.capacity() << ", Address: " << &vec[0] << std::endl;

    // 添加元素并观察扩容
    for (int i = 0; i < 10; ++i) {
        vec.push_back(i);
        std::cout << "Size: " << vec.size() << ", Capacity: " << vec.capacity() << std::endl;
    }

    // 查看地址
    std::cout << "After push - Capacity: " << vec.capacity() << ", Address: " << &vec[0] << std::endl;
    return 0;
}
```

在这个示例中，vec 的容量**会且仅会**在需要时自动扩展，输出会显示每次扩展后的大小和容量。
结论：扩容会从 1 开始，每次扩容为之前的 2 倍，如 1，2，4，8，16 等。

### Shrink
`std::vector` 在删除元素后不会自动减少其容量。为了减少内存占用，可以使用`shrink_to_fit` 方法，该方法会尝试减少 `std::vector` 的容量以适应其大小。

以下是一个示例，演示如何缩小 ~std::vector~ 的容量：
```cpp
#include <iostream>
#include <vector>

int main() {
    std::vector<int> vec;

    // 初始情况
    std::cout << "Initail Capacity: " << vec.capacity() << ", Address: " << &vec[0] << std::endl;
    // 添加元素
    for (int i = 0; i < 10; ++i) {
        vec.push_back(i);
        std::cout << "Size: " << vec.size() << ", Capacity: " << vec.capacity() << ",Address:" << &vec[0] << std::endl;
    }

    // 删除元素
    vec.erase(vec.begin() + 5, vec.end());
    std::cout << "After erase - Size: " << vec.size() << ", Capacity: " << vec.capacity() << ", Address: " << &vec[0] << std::endl;

    // 缩小内存
    vec.shrink_to_fit();
    std::cout << "After shrink_to_fit - Size: " << vec.size() << ", Capacity: " << vec.capacity() << ", Address: " << &vec[0] << std::endl;

    return 0;
}

```

结论：`std::vector` 每次扩容或缩容都会重新申请内存地址。

## Ordered & Unordered
在 C++ 的标准模板库（STL）中，`unordered` 容器和 `ordered` 容器有显著的区别。

### Unordered Container
unordered 容器基于哈希表实现，包含以下几种主要类型：
1. `std::unordered_set`
2. `std::unordered_map`
3. `std::unordered_multiset`
4. `std::unordered_multimap`

#### Features
unordered 容器特点如下：
1. 无序性：元素没有特定的顺序。插入顺序不影响元素的存储顺序。
2. 哈希表实现：使用哈希函数对元素进行组织和查找。
3. 平均常数时间复杂度：对于插入、删除和查找操作，通常可以在平均常数时间内完成。这使得它们非常适合需要快速查找的场景。
4. 迭代器：由于无序性，迭代器遍历元素的顺序不确定。

#### Scene
1. 需要快速查找、插入和删除操作的场景。
2. 不关心元素顺序的情况。

### Ordered Container
`ordered` 容器基于树（通常是红黑树）实现，包含以下几种主要类型：
1. `std::set`
2. `std::map`
3. `std::multiset`
4. `std::multimap`

#### Features
ordered 容器特点如下：
1. 有序性：元素按特定顺序存储（通常是按升序排列）。插入顺序可能会影响元素的存储顺序。
2. 二叉树实现：使用平衡二叉树（例如红黑树）对元素进行组织和查找。
3. 对数时间复杂度：对于插入、删除和查找操作，通常可以在对数时间内完成。这使得它们适合需要有序访问的场景。
4. 迭代器：迭代器遍历元素时，按照存储顺序进行（例如升序）

#### Scene
1. 需要元素按顺序存储和访问的场景。
2. 需要有序的范围查询操作的情况（例如查找某个范围内的元素）。

### Example
下面是一个简单的示例，展示如何使用 `unordered_map` 和 `map`:

```cpp
#include <iostream>
#include <unordered_map>
#include <map>

int main() {
    // unordered_map 示例
    std::unordered_map<int, std::string> umap;
    umap[1] = "one";
    umap[3] = "three";
    umap[2] = "two";

    std::cout << "Unordered map elements:" << std::endl;
    for (const auto& pair : umap) {
        std::cout << pair.first << ": " << pair.second << std::endl;
    }

    // map 示例
    std::map<int, std::string> omap;
    omap[1] = "one";
    omap[3] = "three";
    omap[2] = "two";

    std::cout << "Ordered map elements:" << std::endl;
    for (const auto& pair : omap) {
        std::cout << pair.first << ": " << pair.second << std::endl;
    }

    return 0;
}
```