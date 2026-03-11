import 'package:flutter/material.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _selectedTab = 0;

  final List<Map<String, dynamic>> _upcomingAppointments = [
    {
      "doctorName": "Dr. Sarah Johnson",
      "specialty": "Cardiologist",
      "date": "2024-03-20",
      "day": "Wednesday",
      "time": "10:30 AM",
      "duration": "30 min",
      "type": "Video Consult",
      "status": "Confirmed",
      "avatar": "assets/images/doctor1.jpg",
      "location": "Online Meeting",
      "notes": "Please bring your latest test reports",
    },
    {
      "doctorName": "Dr. Michael Chen",
      "specialty": "Neurologist",
      "date": "2024-03-22",
      "day": "Friday",
      "time": "2:00 PM",
      "duration": "45 min",
      "type": "Clinic Visit",
      "status": "Pending",
      "avatar": "assets/images/doctor2.jpg",
      "location": "City Medical Center, Room 305",
      "notes": "First consultation",
    },
    {
      "doctorName": "Dr. Emily Williams",
      "specialty": "Pediatrician",
      "date": "2024-03-25",
      "day": "Monday",
      "time": "11:15 AM",
      "duration": "30 min",
      "type": "Home Visit",
      "status": "Confirmed",
      "avatar": "assets/images/doctor3.jpg",
      "location": "Your Home Address",
      "notes": "Child vaccination due",
    },
  ];

  final List<Map<String, dynamic>> _pastAppointments = [
    {
      "doctorName": "Dr. James Wilson",
      "specialty": "Dermatologist",
      "date": "2024-03-10",
      "day": "Monday",
      "time": "9:00 AM",
      "type": "Clinic Visit",
      "status": "Completed",
      "avatar": "assets/images/doctor4.jpg",
      "prescription": true,
    },
    {
      "doctorName": "Dr. Lisa Anderson",
      "specialty": "Psychiatrist",
      "date": "2024-03-05",
      "day": "Tuesday",
      "time": "3:30 PM",
      "type": "Video Consult",
      "status": "Completed",
      "avatar": "assets/images/doctor1.jpg",
      "prescription": false,
    },
    {
      "doctorName": "Dr. Robert Brown",
      "specialty": "General Physician",
      "date": "2024-02-28",
      "day": "Wednesday",
      "time": "10:00 AM",
      "type": "Clinic Visit",
      "status": "Cancelled",
      "avatar": "assets/images/doctor2.jpg",
      "prescription": false,
    },
  ];

  final List<Map<String, dynamic>> _availableTimeSlots = [
    {"time": "09:00 AM", "available": true},
    {"time": "10:00 AM", "available": true},
    {"time": "11:00 AM", "available": false},
    {"time": "12:00 PM", "available": true},
    {"time": "02:00 PM", "available": true},
    {"time": "03:00 PM", "available": false},
    {"time": "04:00 PM", "available": true},
    {"time": "05:00 PM", "available": true},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _selectedTab = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(),

            // Date Selector
            _buildDateSelector(),

            // Tab Bar
            _buildTabBar(),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildUpcomingAppointments(),
                  _buildPastAppointments(),
                  _buildScheduleCalendar(),
                ],
              ),
            ),
          ],
        ),
      ),

      // Floating Action Button
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showNewAppointmentSheet();
        },
        backgroundColor: Color(0xFF7165D6),
        icon: Icon(Icons.add, color: Colors.white),
        label: Text("Book New", style: TextStyle(color: Colors.white)),
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
                "My Schedule",
                style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black87),
              ),
              SizedBox(height: 5),
              Text(
                "Manage your appointments",
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
            ],
          ),
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
            child: Icon(Icons.calendar_month, color: Color(0xFF7165D6)),
          ),
        ],
      ),
    );
  }

  Widget _buildDateSelector() {
    DateTime now = DateTime.now();
    return Container(
      height: 100,
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 7,
        itemBuilder: (context, index) {
          DateTime date = now.add(Duration(days: index));
          bool isSelected = index == 0;

          return GestureDetector(
            onTap: () {
              // Handle date selection
            },
            child: Container(
              width: 60,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(colors: [Color(0xFF7165D6), Color(0xFF9B8EFC)])
                    : null,
                color: isSelected ? null : Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 5,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _getDayAbbr(date),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.grey[500],
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    date.day.toString(),
                    style: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTabBar() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      padding: EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey[300]!, width: 1),
      ),
      child: Row(
        children: [
          _buildTabItem("Upcoming", 0, Icons.upcoming),
          _buildTabItem("Past", 1, Icons.history),
          _buildTabItem("Calendar", 2, Icons.calendar_month),
        ],
      ),
    );
  }

  Widget _buildTabItem(String label, int index, IconData icon) {
    bool isSelected = _selectedTab == index;

    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedTab = index;
            _tabController.animateTo(index);
          });
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF7165D6) : Colors.transparent,
            borderRadius: BorderRadius.circular(12),
            boxShadow: isSelected
                ? [
                    BoxShadow(
                      color: Color(0xFF7165D6).withOpacity(0.3),
                      blurRadius: 8,
                      offset: Offset(0, 3),
                    ),
                  ]
                : null,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 18, color: isSelected ? Colors.white : Colors.grey[500]),
              SizedBox(width: 8),
              Text(
                label,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey[600],
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingAppointments() {
    if (_upcomingAppointments.isEmpty) {
      return _buildEmptyState(
        icon: Icons.event_available,
        title: "No Upcoming Appointments",
        subtitle: "Book your next appointment with a doctor",
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: _upcomingAppointments.length,
      itemBuilder: (context, index) {
        final appointment = _upcomingAppointments[index];
        return _buildAppointmentCard(appointment);
      },
    );
  }

  Widget _buildAppointmentCard(Map<String, dynamic> appointment) {
    return Container(
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.1), blurRadius: 10, offset: Offset(0, 5)),
        ],
      ),
      child: Column(
        children: [
          // Doctor Info Row
          Row(
            children: [
              CircleAvatar(radius: 30, backgroundImage: AssetImage(appointment["avatar"])),
              SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          appointment["doctorName"],
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          decoration: BoxDecoration(
                            color: appointment["status"] == "Confirmed"
                                ? Colors.green.withOpacity(0.1)
                                : Colors.orange.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            appointment["status"],
                            style: TextStyle(
                              color: appointment["status"] == "Confirmed"
                                  ? Colors.green
                                  : Colors.orange,
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 3),
                    Text(
                      appointment["specialty"],
                      style: TextStyle(color: Colors.grey[600], fontSize: 13),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 15),
          Divider(color: Colors.grey[200]),
          SizedBox(height: 15),

          // Appointment Details
          Row(
            children: [
              _buildDetailItem(
                Icons.calendar_today,
                "${appointment["day"]}, ${appointment["date"]}",
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              _buildDetailItem(
                Icons.access_time,
                "${appointment["time"]} (${appointment["duration"]})",
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              _buildDetailItem(
                appointment["type"] == "Video Consult" ? Icons.videocam : Icons.location_on,
                appointment["location"],
              ),
            ],
          ),

          if (appointment["notes"] != null) ...[
            SizedBox(height: 10),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Color(0xFF7165D6).withOpacity(0.05),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 16, color: Color(0xFF7165D6)),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      appointment["notes"],
                      style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                    ),
                  ),
                ],
              ),
            ),
          ],

          SizedBox(height: 15),

          // Action Buttons
          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () {
                    _showRescheduleDialog(appointment);
                  },
                  style: OutlinedButton.styleFrom(
                    foregroundColor: Color(0xFF7165D6),
                    side: BorderSide(color: Color(0xFF7165D6)),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text("Reschedule"),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    _showAppointmentDetails(appointment);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF7165D6),
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child: Text("Details"),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 16, color: Color(0xFF7165D6)),
        SizedBox(width: 8),
        Text(text, style: TextStyle(fontSize: 13, color: Colors.grey[700])),
      ],
    );
  }

  Widget _buildPastAppointments() {
    if (_pastAppointments.isEmpty) {
      return _buildEmptyState(
        icon: Icons.history,
        title: "No Past Appointments",
        subtitle: "Your appointment history will appear here",
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(20),
      itemCount: _pastAppointments.length,
      itemBuilder: (context, index) {
        final appointment = _pastAppointments[index];
        return Container(
          margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
          child: Row(
            children: [
              CircleAvatar(radius: 25, backgroundImage: AssetImage(appointment["avatar"])),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      appointment["doctorName"],
                      style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 3),
                    Text(
                      appointment["specialty"],
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(Icons.calendar_today, size: 12, color: Colors.grey[400]),
                        SizedBox(width: 4),
                        Text(
                          "${appointment["day"]}, ${appointment["date"]}",
                          style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.access_time, size: 12, color: Colors.grey[400]),
                        SizedBox(width: 4),
                        Text(
                          appointment["time"],
                          style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Column(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: appointment["status"] == "Completed"
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      appointment["status"],
                      style: TextStyle(
                        color: appointment["status"] == "Completed" ? Colors.green : Colors.red,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  if (appointment["prescription"]) SizedBox(height: 5),
                  if (appointment["prescription"])
                    IconButton(
                      icon: Icon(Icons.description, color: Color(0xFF7165D6), size: 20),
                      onPressed: () {},
                    ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildScheduleCalendar() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20),
      child: Column(
        children: [
          // Mini Calendar
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              children: [
                // Month header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(icon: Icon(Icons.chevron_left), onPressed: () {}),
                    Text("March 2024", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                    IconButton(icon: Icon(Icons.chevron_right), onPressed: () {}),
                  ],
                ),
                SizedBox(height: 15),

                // Week days
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]
                      .map(
                        (day) => Text(
                          day,
                          style: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      )
                      .toList(),
                ),
                SizedBox(height: 10),

                // Calendar grid
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    childAspectRatio: 1,
                  ),
                  itemCount: 35,
                  itemBuilder: (context, index) {
                    int day = index + 1;
                    bool hasAppointment = [20, 22, 25].contains(day);
                    bool isToday = day == 15;

                    return GestureDetector(
                      onTap: () {},
                      child: Container(
                        margin: EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: isToday
                              ? Color(0xFF7165D6)
                              : hasAppointment
                              ? Color(0xFF7165D6).withOpacity(0.1)
                              : null,
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            day.toString(),
                            style: TextStyle(
                              color: isToday
                                  ? Colors.white
                                  : hasAppointment
                                  ? Color(0xFF7165D6)
                                  : Colors.black87,
                              fontWeight: hasAppointment ? FontWeight.bold : null,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          SizedBox(height: 20),

          // Available Time Slots
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.1),
                  blurRadius: 10,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Available Time Slots",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  children: _availableTimeSlots.map((slot) {
                    return Container(
                      width: (MediaQuery.of(context).size.width - 100) / 3,
                      padding: EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: slot["available"]
                            ? Color(0xFF7165D6).withOpacity(0.1)
                            : Colors.grey[100],
                        borderRadius: BorderRadius.circular(10),
                        border: slot["available"] ? Border.all(color: Color(0xFF7165D6)) : null,
                      ),
                      child: Center(
                        child: Text(
                          slot["time"],
                          style: TextStyle(
                            color: slot["available"] ? Color(0xFF7165D6) : Colors.grey[400],
                            fontSize: 12,
                            fontWeight: slot["available"] ? FontWeight.w600 : null,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 80, color: Colors.grey[300]),
          SizedBox(height: 20),
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.grey[600]),
          ),
          SizedBox(height: 10),
          Text(
            subtitle,
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              _showNewAppointmentSheet();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF7165D6),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
            ),
            child: Text("Book Appointment"),
          ),
        ],
      ),
    );
  }

  void _showNewAppointmentSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.8,
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
                "Book New Appointment",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 20),
                children: [
                  // Doctor selection would go here
                  // This is a simplified version
                  ListTile(
                    leading: CircleAvatar(backgroundImage: AssetImage("assets/images/doctor1.jpg")),
                    title: Text("Dr. Sarah Johnson"),
                    subtitle: Text("Cardiologist"),
                    trailing: Icon(Icons.add_circle, color: Color(0xFF7165D6)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: CircleAvatar(backgroundImage: AssetImage("assets/images/doctor2.jpg")),
                    title: Text("Dr. Michael Chen"),
                    subtitle: Text("Neurologist"),
                    trailing: Icon(Icons.add_circle, color: Color(0xFF7165D6)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    leading: CircleAvatar(backgroundImage: AssetImage("assets/images/doctor3.jpg")),
                    title: Text("Dr. Emily Williams"),
                    subtitle: Text("Pediatrician"),
                    trailing: Icon(Icons.add_circle, color: Color(0xFF7165D6)),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRescheduleDialog(Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Reschedule Appointment"),
        content: Text(
          "Select a new date and time for your appointment with ${appointment["doctorName"]}",
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              // Handle reschedule logic
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("Appointment rescheduled successfully!"),
                  backgroundColor: Colors.green,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: Color(0xFF7165D6)),
            child: Text("Confirm"),
          ),
        ],
      ),
    );
  }

  void _showAppointmentDetails(Map<String, dynamic> appointment) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Appointment Details"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildDetailRow("Doctor:", appointment["doctorName"]),
            _buildDetailRow("Specialty:", appointment["specialty"]),
            _buildDetailRow("Date:", "${appointment["day"]}, ${appointment["date"]}"),
            _buildDetailRow("Time:", appointment["time"]),
            _buildDetailRow("Type:", appointment["type"]),
            _buildDetailRow("Location:", appointment["location"]),
            if (appointment["notes"] != null) _buildDetailRow("Notes:", appointment["notes"]),
          ],
        ),
        actions: [TextButton(onPressed: () => Navigator.pop(context), child: Text("Close"))],
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$label ", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
          Expanded(child: Text(value, style: TextStyle(fontSize: 13))),
        ],
      ),
    );
  }

  String _getDayAbbr(DateTime date) {
    switch (date.weekday) {
      case 1:
        return "MON";
      case 2:
        return "TUE";
      case 3:
        return "WED";
      case 4:
        return "THU";
      case 5:
        return "FRI";
      case 6:
        return "SAT";
      case 7:
        return "SUN";
      default:
        return "";
    }
  }
}
