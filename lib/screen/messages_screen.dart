import 'package:flutter/material.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  final List<Map<String, dynamic>> _chats = [
    {
      "name": "Dr. Sarah Johnson",
      "specialty": "Cardiologist",
      "lastMessage": "Your test results are normal. Please schedule a follow-up...",
      "time": "10:30 AM",
      "unread": 2,
      "avatar": "assets/images/doctor1.jpg",
      "online": true,
      "image": "assets/images/doctor1.jpg",
    },
    {
      "name": "Dr. Michael Chen",
      "specialty": "Neurologist",
      "lastMessage": "How are you feeling today? Any improvements?",
      "time": "Yesterday",
      "unread": 0,
      "avatar": "assets/images/doctor2.jpg",
      "online": false,
      "image": "assets/images/doctor2.jpg",
    },
    {
      "name": "Dr. Emily Williams",
      "specialty": "Pediatrician",
      "lastMessage": "Your child's vaccination is due next week. Please...",
      "time": "Yesterday",
      "unread": 1,
      "avatar": "assets/images/doctor3.jpg",
      "online": true,
      "image": "assets/images/doctor3.jpg",
    },
    {
      "name": "Dr. James Wilson",
      "specialty": "Dermatologist",
      "lastMessage": "I've reviewed your skin condition. Let's schedule a...",
      "time": "2 days ago",
      "unread": 0,
      "avatar": "assets/images/doctor4.jpg",
      "online": false,
      "image": "assets/images/doctor4.jpg",
    },
    {
      "name": "Dr. Lisa Anderson",
      "specialty": "Psychiatrist",
      "lastMessage": "Your therapy session is confirmed for tomorrow at 3 PM",
      "time": "3 days ago",
      "unread": 0,
      "avatar": "assets/images/doctor1.jpg",
      "online": false,
      "image": "assets/images/doctor1.jpg",
    },
  ];

  final List<Map<String, dynamic>> _recentCalls = [
    {
      "name": "Dr. Sarah Johnson",
      "type": "Video Call",
      "time": "Today, 09:30 AM",
      "status": "Missed",
      "avatar": "assets/images/doctor1.jpg",
    },
    {
      "name": "Dr. Michael Chen",
      "type": "Audio Call",
      "time": "Yesterday, 2:15 PM",
      "status": "Completed",
      "avatar": "assets/images/doctor2.jpg",
    },
    {
      "name": "Dr. Emily Williams",
      "type": "Video Call",
      "time": "Yesterday, 11:00 AM",
      "status": "Completed",
      "avatar": "assets/images/doctor3.jpg",
    },
  ];

  int _selectedTab = 0; // 0 for Chats, 1 for Calls

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),

            // Search Bar
            _buildSearchBar(),

            // Tab Bar
            _buildTabBar(),

            // Content based on selected tab
            Expanded(child: _selectedTab == 0 ? _buildChatsList() : _buildCallsList()),
          ],
        ),
      ),

      // Floating Action Button for new message/call
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showNewChatBottomSheet();
        },
        backgroundColor: Color(0xFF7165D6),
        child: Icon(_selectedTab == 0 ? Icons.chat : Icons.call, color: Colors.white),
      ),
    );
  }

  Widget _buildHeader() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Messages",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              SizedBox(height: 5),
              Text(
                "Connect with your doctors",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
          Stack(
            children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Icon(Icons.notifications_outlined, color: Color(0xFF7165D6)),
              ),
              Positioned(
                top: 5,
                right: 5,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
          ],
        ),
        child: TextField(
          decoration: InputDecoration(
            hintText: "Search doctors or messages...",
            hintStyle: TextStyle(color: Colors.grey[400]),
            prefixIcon: Icon(Icons.search, color: Color(0xFF7165D6)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: EdgeInsets.symmetric(vertical: 15),
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(5),
        decoration: BoxDecoration(color: Colors.grey[200], borderRadius: BorderRadius.circular(30)),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTab = 0;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: _selectedTab == 0 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: _selectedTab == 0
                        ? [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.chat_bubble_outline,
                        color: _selectedTab == 0 ? Color(0xFF7165D6) : Colors.grey[500],
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Chats",
                        style: TextStyle(
                          color: _selectedTab == 0 ? Color(0xFF7165D6) : Colors.grey[500],
                          fontWeight: _selectedTab == 0 ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedTab = 1;
                  });
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12),
                  decoration: BoxDecoration(
                    color: _selectedTab == 1 ? Colors.white : Colors.transparent,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: _selectedTab == 1
                        ? [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              blurRadius: 5,
                              offset: Offset(0, 2),
                            ),
                          ]
                        : null,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.call_outlined,
                        color: _selectedTab == 1 ? Color(0xFF7165D6) : Colors.grey[500],
                        size: 20,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Calls",
                        style: TextStyle(
                          color: _selectedTab == 1 ? Color(0xFF7165D6) : Colors.grey[500],
                          fontWeight: _selectedTab == 1 ? FontWeight.w600 : FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatsList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20),
      itemCount: _chats.length,
      itemBuilder: (context, index) {
        final chat = _chats[index];
        return _buildChatItem(chat);
      },
    );
  }

  Widget _buildChatItem(Map<String, dynamic> chat) {
    return GestureDetector(
      onTap: () {
        _openChat(chat);
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 15),
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
          ],
        ),
        child: Row(
          children: [
            // Avatar with online indicator
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: chat["online"] ? Colors.green : Colors.grey[300]!,
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(radius: 30, backgroundImage: AssetImage(chat["avatar"])),
                ),
                if (chat["online"])
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 15),

            // Chat details
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        chat["name"],
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(chat["time"], style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                    ],
                  ),
                  SizedBox(height: 3),
                  Text(chat["specialty"], style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                  SizedBox(height: 5),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat["lastMessage"],
                          style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (chat["unread"] > 0)
                        Container(
                          margin: EdgeInsets.only(left: 8),
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Color(0xFF7165D6),
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            chat["unread"].toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCallsList() {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: 20),
      children: [
        // Today's calls section
        if (_recentCalls.any((call) => call["time"].contains("Today")))
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Today",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[600]),
            ),
          ),
        ..._recentCalls
            .where((call) => call["time"].contains("Today"))
            .map((call) => _buildCallItem(call)),

        // Yesterday's calls section
        if (_recentCalls.any((call) => call["time"].contains("Yesterday")))
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Yesterday",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[600]),
            ),
          ),
        ..._recentCalls
            .where((call) => call["time"].contains("Yesterday"))
            .map((call) => _buildCallItem(call)),

        // Older calls section
        if (_recentCalls.any(
          (call) => !call["time"].contains("Today") && !call["time"].contains("Yesterday"),
        ))
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              "Older",
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.grey[600]),
            ),
          ),
        ..._recentCalls
            .where((call) => !call["time"].contains("Today") && !call["time"].contains("Yesterday"))
            .map((call) => _buildCallItem(call)),
      ],
    );
  }

  Widget _buildCallItem(Map<String, dynamic> call) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          CircleAvatar(radius: 25, backgroundImage: AssetImage(call["avatar"])),
          SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(call["name"], style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                SizedBox(height: 3),
                Row(
                  children: [
                    Icon(
                      call["type"] == "Video Call" ? Icons.videocam : Icons.call,
                      size: 14,
                      color: Colors.grey[500],
                    ),
                    SizedBox(width: 5),
                    Text(call["type"], style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                    Text("  •  ", style: TextStyle(color: Colors.grey[400])),
                    Text(call["time"], style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                  ],
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: call["status"] == "Missed"
                  ? Colors.red.withOpacity(0.1)
                  : Colors.green.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              call["status"],
              style: TextStyle(
                color: call["status"] == "Missed" ? Colors.red : Colors.green,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(width: 10),
          Icon(Icons.phone_callback, color: Color(0xFF7165D6), size: 20),
        ],
      ),
    );
  }

  void _openChat(Map<String, dynamic> chat) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => ChatDetailScreen(chat: chat)));
  }

  void _showNewChatBottomSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(10),
              width: 40,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Text(
                _selectedTab == 0 ? "New Message" : "New Call",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20),
                itemCount: _chats.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: CircleAvatar(backgroundImage: AssetImage(_chats[index]["avatar"])),
                    title: Text(_chats[index]["name"]),
                    subtitle: Text(_chats[index]["specialty"]),
                    onTap: () {
                      Navigator.pop(context);
                      // Handle new message/call
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Chat Detail Screen
class ChatDetailScreen extends StatefulWidget {
  final Map<String, dynamic> chat;

  const ChatDetailScreen({super.key, required this.chat});

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final TextEditingController _messageController = TextEditingController();
  final List<Map<String, dynamic>> _messages = [
    {
      "text": "Hello Doctor, I've been having some chest pain lately",
      "time": "10:15 AM",
      "isMe": true,
    },
    {
      "text": "I'm sorry to hear that. Can you describe the pain?",
      "time": "10:16 AM",
      "isMe": false,
    },
    {"text": "It's a sharp pain that comes and goes", "time": "10:17 AM", "isMe": true},
    {"text": "How long does it typically last?", "time": "10:18 AM", "isMe": false},
    {"text": "About 5-10 minutes each time", "time": "10:19 AM", "isMe": true},
    {
      "text": "I'd like to schedule an appointment to examine you properly",
      "time": "10:20 AM",
      "isMe": false,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(radius: 20, backgroundImage: AssetImage(widget.chat["avatar"])),
                if (widget.chat["online"])
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.chat["name"],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Text(
                  widget.chat["online"] ? "Online" : "Offline",
                  style: TextStyle(
                    fontSize: 12,
                    color: widget.chat["online"] ? Colors.green : Colors.grey[500],
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.phone, color: Color(0xFF7165D6)),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.videocam, color: Color(0xFF7165D6)),
            onPressed: () {},
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert, color: Colors.black87),
            itemBuilder: (context) => [
              PopupMenuItem(child: Text("View Profile"), value: "profile"),
              PopupMenuItem(child: Text("Clear Chat"), value: "clear"),
              PopupMenuItem(child: Text("Block Doctor"), value: "block"),
            ],
          ),
        ],
      ),
      body: Column(
        children: [
          // Chat messages
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(20),
              reverse: true,
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[_messages.length - 1 - index];
                return _buildMessageBubble(message);
              },
            ),
          ),

          // Message input
          Container(
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, -5),
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: "Type a message...",
                        border: InputBorder.none,
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Container(
                  decoration: BoxDecoration(color: Color(0xFF7165D6), shape: BoxShape.circle),
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: () {
                      if (_messageController.text.isNotEmpty) {
                        setState(() {
                          _messages.add({
                            "text": _messageController.text,
                            "time": "Just now",
                            "isMe": true,
                          });
                          _messageController.clear();
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(Map<String, dynamic> message) {
    final isMe = message["isMe"];

    return Container(
      margin: EdgeInsets.only(bottom: 15),
      child: Row(
        mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isMe) CircleAvatar(radius: 15, backgroundImage: AssetImage(widget.chat["avatar"])),
          SizedBox(width: !isMe ? 10 : 0),
          Flexible(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              decoration: BoxDecoration(
                color: isMe ? Color(0xFF7165D6) : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                  bottomLeft: isMe ? Radius.circular(15) : Radius.circular(0),
                  bottomRight: isMe ? Radius.circular(0) : Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message["text"],
                    style: TextStyle(color: isMe ? Colors.white : Colors.black87, fontSize: 14),
                  ),
                  SizedBox(height: 5),
                  Text(
                    message["time"],
                    style: TextStyle(color: isMe ? Colors.white70 : Colors.grey[500], fontSize: 10),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
