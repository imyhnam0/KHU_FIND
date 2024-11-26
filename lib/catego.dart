import 'package:flutter/material.dart';
import 'postdetail.dart';

class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final List<String> categories = ['전화기', '지갑', '에어팟'];
  final List<Map<String, dynamic>> items = [
    {'image': 'assets/headset.png', 'category': '전화기'},
    {'image': 'assets/smartphone.png', 'category': '에어팟'},
    {'image': 'assets/wallet.png', 'category': '지갑'},
  ];

  List<bool> selectedCategories = [false, false, false];
  List<Map<String, dynamic>> filteredItems = [];

  @override
  void initState() {
    super.initState();
    filteredItems = items;
  }
  void _deleteItem(int index) {
    setState(() {
      filteredItems.removeAt(index);
    });
  }

  void _filterItems() {
    setState(() {
      final selectedCategory = categories
          .asMap()
          .entries
          .where((entry) => selectedCategories[entry.key])
          .map((entry) => entry.value)
          .toList();

      if (selectedCategory.isEmpty) {
        filteredItems = items;
      } else {
        filteredItems = items
            .where((item) => selectedCategory.contains(item['category']))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '카테고리',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 92, 6, 31),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 20),
          Center(
            child: ToggleButtons(
              isSelected: selectedCategories,
              onPressed: (index) {
                setState(() {
                  selectedCategories[index] = !selectedCategories[index];
                  _filterItems();
                });
              },
              borderRadius: BorderRadius.circular(8),
              selectedColor: Colors.white,
              fillColor: Colors.deepPurple,
              borderColor: Colors.grey,
              selectedBorderColor: Colors.deepPurple,
              children: categories
                  .map(
                    (category) => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    category,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              )
                  .toList(),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: filteredItems.length,
              itemBuilder: (context, index) {
                final item = filteredItems[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                  child: Stack(
                    children: [
                      // 이미지 컨테이너 (클릭 가능하도록 GestureDetector 추가)
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => PostDetailPage(),
                            ),
                          );
                        },
                        child: Container(
                          width: double.infinity,
                          height: 300,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey),
                            image: DecorationImage(
                              image: AssetImage(item['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      // 수정 버튼
                      Positioned(
                        top: 10,
                        right: 10,
                        child: ElevatedButton(
                          onPressed: () {

                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('수정'),
                        ),
                      ),
                      // 삭제 버튼
                      Positioned(
                        bottom: 10,
                        right: 10,
                        child: ElevatedButton(
                          onPressed: () {
                            _deleteItem(index);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: const Text('삭제'),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
