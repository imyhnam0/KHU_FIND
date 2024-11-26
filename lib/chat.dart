import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _controller = TextEditingController();
  final List<Map<String, String>> _messages = [];
  int _responseIndex = 0;

  final List<String> _responses = [
    '어 저는 못봤어요',
    '어디서 잃어버리셨나요?',
    '네 수고하세요',

  ];

  void _sendMessage(String text) {
    if (text.isEmpty) return;

    setState(() {
      _messages.add({'user': text}); // 사용자의 메시지 추가
      _controller.clear(); // 입력 필드 비우기
    });

    // 상대방의 응답 추가 (딜레이 추가 가능)
    Future.delayed(const Duration(milliseconds: 800), () {
      if (_responseIndex < _responses.length) {
        setState(() {
          _messages.add({'bot': _responses[_responseIndex]}); // 봇의 응답 추가
          _responseIndex++;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('채팅'),
        backgroundColor: const Color.fromARGB(255, 92, 6, 31),
      ),
      body: Column(
        children: [
          // 채팅 메시지 표시 영역
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16.0),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message.containsKey('user');

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 4.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue : Colors.grey[300],
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      isUser ? message['user']! : message['bot']!,
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // 입력 필드와 버튼
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: '메시지 입력...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),
                ElevatedButton(
                  onPressed: () => _sendMessage(_controller.text),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                    backgroundColor: const Color.fromARGB(255, 92, 6, 31),
                  ),
                  child: const Text('전송'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
