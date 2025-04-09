import 'package:flutter/material.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ChatbotPage extends StatefulWidget {
  @override
  _ChatbotPageState createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final TextEditingController _messageController = TextEditingController();
  final String apiKey = dotenv.env['GEMINI_API_KEY'] ?? ''; // Load API key

  late final GenerativeModel model;

  @override
  void initState() {
    super.initState();
    model = GenerativeModel(model: 'gemini-1.5-flash-latest', apiKey: apiKey);
  }

  List<Map<String, String>> _messages = [];

  void _sendMessage() async {
    String userMessage = _messageController.text.trim();
    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add({"sender": "user", "text": userMessage});
    });

    _messageController.clear();

    try {
      GenerateContentResponse response =
          await model.generateContent([Content.text(userMessage)]);
      String botResponse =
          response.text ?? "I'm not sure how to respond to that 🤖";

      setState(() {
        _messages.add({"sender": "bot", "text": botResponse});
      });
    } catch (e) {
      print("❌ ERROR: $e"); // Debugging
      setState(() {
        _messages.add(
            {"sender": "bot", "text": "Oops! Something went wrong. Error: $e"});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          "Chatbot",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                final isUser = message["sender"] == "user";
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 14),
                    decoration: BoxDecoration(
                      color: isUser
                          ? Color(0xFF8A56F0) // sleek purple tone
                          : Colors.grey.shade900, // dark bubble for bot
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(18),
                        topRight: Radius.circular(18),
                        bottomLeft:
                            isUser ? Radius.circular(18) : Radius.circular(0),
                        bottomRight:
                            isUser ? Radius.circular(0) : Radius.circular(18),
                      ),
                    ),
                    child: Text(
                      message["text"]!,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.white,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(12, 8, 12, 16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Type a message...",
                      hintStyle: TextStyle(color: Colors.grey.shade500),
                      filled: true,
                      fillColor: Colors.grey.shade900,
                      contentPadding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  height: 45,
                  width: 45,
                  child: FloatingActionButton(
                    onPressed: _sendMessage,
                    child: Icon(Icons.send, size: 20, color: Colors.white),
                    backgroundColor: Color(0xFF8A56F0),
                    elevation: 0,
                    mini: true,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );

    // return Scaffold(
    //   appBar: AppBar(
    //     title: Text(
    //       "Chatbot",
    //       style: TextStyle(color: Colors.white),
    //     ),
    //     backgroundColor: Colors.black,
    //   ),
    //   body: Column(
    //     children: [
    //       Expanded(
    //         child: ListView.builder(
    //           reverse: true,
    //           itemCount: _messages.length,
    //           itemBuilder: (context, index) {
    //             final message = _messages[_messages.length - 1 - index];
    //             final isUser = message["sender"] == "user";
    //             return Align(
    //               alignment:
    //                   isUser ? Alignment.centerRight : Alignment.centerLeft,
    //               child: Container(
    //                 margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
    //                 padding: EdgeInsets.all(10),
    //                 decoration: BoxDecoration(
    //                   color:
    //                       isUser ? Colors.pink.shade200 : Colors.grey.shade300,
    //                   borderRadius: BorderRadius.circular(15),
    //                 ),
    //                 child: Text(
    //                   message["text"]!,
    //                   style: TextStyle(fontSize: 16, color: Colors.black),
    //                 ),
    //               ),
    //             );
    //           },
    //         ),
    //       ),
    //       Padding(
    //         padding: EdgeInsets.all(10),
    //         child: Row(
    //           children: [
    //             Expanded(
    //               child: TextField(
    //                 controller: _messageController,
    //                 decoration: InputDecoration(
    //                   hintText: "Type a message...",
    //                   border: OutlineInputBorder(
    //                     borderRadius: BorderRadius.circular(20),
    //                   ),
    //                 ),
    //               ),
    //             ),
    //             SizedBox(width: 10),
    //             FloatingActionButton(
    //               onPressed: _sendMessage,
    //               child: Icon(Icons.send, color: Colors.white),
    //               backgroundColor: Colors.pink,
    //               mini: true,
    //             ),
    //           ],
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }
}
