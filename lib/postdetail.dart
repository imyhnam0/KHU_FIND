import 'package:flutter/material.dart';

class Post {
  final String date;
  final String userId;
  final String description;
  final String imagePath;
  final String locationImagePath;
  final String storelocation;
  final String status;

  Post({
    required this.date,
    required this.userId,
    required this.description,
    required this.imagePath,
    required this.locationImagePath,
    required this.storelocation,
    required this.status,
  });
}

class PostDetailPage extends StatelessWidget {
  const PostDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 더미 데이터 생성
    final dummyPost = Post(
      date: '2024-11-26',
      userId: 'user123',
      description: '분실물 습득 장소는 주차장입니다. 오전 10시에 주웠습니다.',
      imagePath: 'assets/wallet.png',
      locationImagePath: 'assets/parkinglot.png',
      storelocation: '다솜 동아리방',
      status: '찾아감',
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          '게시글 상세 내용',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color.fromARGB(255, 92, 6, 31),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView( // Column 대신 ListView 사용
          children: [
            // 작성 날짜
            Text(
              '작성 날짜: ${dummyPost.date}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            // 작성자
            Text(
              '작성자: ${dummyPost.userId}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            // 내용
            Text(
              '내용: ${dummyPost.description}',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            // 분실물 이미지
            const Text(
              '분실물 이미지:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Image.asset(dummyPost.imagePath, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            // 분실물 습득 장소 (네이버 지도)
            const Text(
              '분실물 습득 장소 (네이버 지도):',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Image.asset(dummyPost.locationImagePath, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            // storeLocation 표시
            const Text(
              '보관 위치:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              dummyPost.storelocation, // storeLocation 출력
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),
            // 상태
            const Text(
              '상태:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              dummyPost.status, // 상태 출력
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
