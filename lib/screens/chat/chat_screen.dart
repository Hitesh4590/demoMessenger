import 'package:demo_messenger/utils/constants.dart';
import 'package:demo_messenger/widgets/message_widget.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChatScreen extends StatefulWidget {
  final String currentUserId;
  final String receiverId;

  const ChatScreen({super.key, required this.currentUserId, required this.receiverId});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final DatabaseReference _database = FirebaseDatabase.instance.ref();

  Future<void> _sendMessage() async {
    if (_messageController.text.trim().isNotEmpty) {
      final timeSend = DateTime.now().toUtc().toIso8601String();
      final message = {
        'text': _messageController.text,
        'senderId': widget.currentUserId,
        'timeSend': timeSend,
      };

      try {
        // Push message to sender's chat path
        final senderRef = _database
            .child('users/${widget.currentUserId}/chats/${widget.receiverId}/messages')
            .push();
        await senderRef.set(message);

        // Push message to receiver's chat path
        final receiverRef = _database
            .child('users/${widget.receiverId}/chats/${widget.currentUserId}/messages')
            .push();
        await receiverRef.set(message);

        _messageController.clear();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to send message: $e')),
        );
      }
    }
  }
  String icon ="";

  // Define the list of menu items with names and icons
  final List<Map<String, dynamic>> uploadOptions = [
    {
      'name': 'Camera',
      'icon': 'assets/icons/camera.svg',
    },
    {
      'name': 'Record',
      'icon': "assets/icons/Record.svg",
    },
    {
      'name': 'Contact',
      'icon': "assets/icons/Contact.svg",
    },
    {
      'name': 'Gallery',
      'icon': "assets/icons/Gallery.svg",
    },
    {
      'name': 'My Location',
      'icon': "assets/icons/location.svg",
    },
    {
      'name': 'Document',
      'icon': "assets/icons/doc.svg",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        leadingWidth: 30,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipOval(
              child: Image.network(
                Constants.profile_image,
                width: 40,
                height: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 40),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    Constants.name,
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    Constants.number,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: Image.asset("assets/icons/Videocamera.png", width: 35, height: 35),
              onPressed: () {
                // Add video call functionality
              },
            ),
            IconButton(
              icon: Image.asset("assets/icons/phone.png", width: 35, height: 35),
              onPressed: () {
                // Add voice call functionality
              },
            ),
            IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () {
                // Add more options functionality
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: Container(
                color: const Color(0xFFD0D1DB),
                child: StreamBuilder(
                  stream: _database
                      .child('users/${widget.currentUserId}/chats/${widget.receiverId}/messages')
                      .orderByChild('timeSend')
                      .onValue,
                  builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
                    if (snapshot.hasError) {
                      return const Center(child: Text('Error loading messages'));
                    }
                    if (!snapshot.hasData || snapshot.data?.snapshot.value == null) {
                      return const Center(child: Text('No messages found'));
                    }

                    final messagesData = snapshot.data!.snapshot.value as Map?;
                    if (messagesData == null) {
                      return const Center(child: Text('No messages found'));
                    }

                    final messagesList = messagesData.values.toList()
                      ..sort((a, b) => a['timeSend'].compareTo(b['timeSend']));

                    return ListView.builder(
                      reverse: true,
                      padding: const EdgeInsets.all(10),
                      itemCount: messagesList.length,
                      itemBuilder: (context, index) {
                        final message = messagesList[messagesList.length - 1 - index];
                        return MessageWidget(
                          text: message['text'],
                          isSent: message['senderId'] == widget.currentUserId,
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Row(
                children: [
                  PopupMenuButton<String>(
                    icon: const Icon(Icons.add, color: Colors.blue, size: 35),
                    onSelected: (String value) {
                      // Handle selection
                    },
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                    ),
                    itemBuilder: (BuildContext context) {
                      return [
                        PopupMenuItem<String>(
                          enabled: false, // Disable direct selection on the item to handle taps via GridView children
                          child: Container(
                            width: 260, // Adjust width to fit 3 columns
                            height: 180, // Adjust height for 2 rows
                            color: Colors.transparent, // White background for the entire popup
                            child: GridView.count(
                              crossAxisCount: 3, // 3 columns
                              mainAxisSpacing: 8, // Spacing between rows
                              crossAxisSpacing: 8, // Spacing between columns
                              childAspectRatio: 1, // Square items
                              children: uploadOptions.map((option) {
                                return GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context, option['name']); // Trigger onSelected with the value
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.transparent, // White background for each grid item
                                      borderRadius: BorderRadius.circular(8), // Optional: Keep rounded corners
                                    ),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        SvgPicture.asset(
                                          option['icon'].toString(),
                                          width: 24,
                                          height: 24,
                                          placeholderBuilder: (context) => SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: SvgPicture.asset('assets/icons/Contact.svg'),
                                          ),
                                          fit: BoxFit.contain,
                                          semanticsLabel: 'icon',
                                          // Icon color remains unchanged (as per your request)
                                        ),
                                        const SizedBox(height: 8), // Spacing between icon and text
                                        Text(
                                          option['name'],
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                            fontSize: 12,
                                            color: Colors.black, // Text color remains unchanged
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      ];
                    },
                    offset: const Offset(0, 40), // Position the menu below the button
                  ),
                  Expanded(
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 120),
                      child: TextField(
                        controller: _messageController,
                        decoration: InputDecoration(
                          hintText: Constants.type,
                          hintStyle: const TextStyle(fontSize: 15, color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(color: Colors.grey),
                          ),
                          contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                        ),
                        maxLines: 3,
                        minLines: 1,
                        keyboardType: TextInputType.multiline,
                        textInputAction: TextInputAction.newline,
                        onSubmitted: (_) => _sendMessage(),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Image.asset("assets/icons/ButtonSend.png", width: 55, height: 55),
                    onPressed: () async {
                      await _sendMessage();
                      setState(() {}); // Refresh UI to reflect new message
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}