import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'refermateprofile.dart';
import 'refermaterewards.dart';

class Refermatehome extends StatefulWidget {
  const Refermatehome({super.key});

  @override
  State<Refermatehome> createState() => _RefermatehomeState();
}

class _RefermatehomeState extends State<Refermatehome> {
  int _referedfriends = 0;
  int _selectedIndex = 1;

  void _shareReferral() {
    setState(() {
      _referedfriends += 1;
    });

    const referralcode = "vaibhav123";
    const message = '''
🚀 Automate WhatsApp Replies & Skyrocket Sales with WABiz!

Never miss a lead again! WABiz is India’s most trusted WhatsApp Business platform, built for modern businesses to automate communication, boost engagement, and drive sales.

✅ 24/7 Auto-Replies for WhatsApp, SMS & Missed Calls
✅ Bulk + Scheduled Messaging with smart templates
✅ Broadcast Manager to reach 1000s in seconds
✅ Real-time Campaign Analytics
✅ Official WhatsApp Business API with 98.5% Delivery Rate
✅ Mobile App + Web Dashboard for complete control

🎯 Pro Yearly Plan: ₹3,000 ₹6,000
🎁 Use referral code $referralcode to get exclusive discounts!

👉 Get Started Now
📱 Available on Play Store & App Store
''';
    Share.share(message);
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> pages = [
      homeContent(), // main referral page
      const refermaterewards(),
      const refermateprofile(),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF133339),
        elevation: 1,
        title: const Text("WABiz",
            style: TextStyle(color: Color.fromARGB(255, 4, 228, 60),
                fontWeight: FontWeight.bold)
        ),
        actions: [
          IconButton(
            icon:const Icon(Icons.dark_mode),
            onPressed: (){}
          )]
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        backgroundColor: Color(0xFF133339),
        selectedItemColor: Color.fromARGB(255, 4, 228, 60),
        unselectedItemColor: Colors.white,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.card_giftcard), label: 'Rewards'),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget homeContent() {
    return Scaffold(
      backgroundColor: const Color(0xFF1F2937),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            earningscard(_referedfriends),
            const SizedBox(height: 16),
            invitecard(_shareReferral),
            const SizedBox(height: 16),
            contactscard(),
            const SizedBox(height: 16),
            howitworkscard(),
          ],
        ),
      ),
    );
  }
}

Widget earningscard(int referedfriends) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const _StatCard(
            icon: Icons.currency_rupee,
            label: "Total Earned",
            value: "₹0",
          ),
          _StatCard(
            icon: Icons.group,
            label: "Friends Referred",
            value: referedfriends.toString(),
          ),
        ],
      ),
    ),
  );
}

Widget invitecard(VoidCallback onInvitePressed) {
  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Invite Friend And Earn Upto ₹100",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          const Text(
            "Share Your Unique Link With Your Friends And Family to Earn Rewards",
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onInvitePressed,
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text("Invite Now"),
            ),
          ),
        ],
      ),
    ),
  );
}

Widget contactscard() {
  final contacts = [
    ["VB", "Vaibhav Baviskar", "+918262836825"],
    ["SB", "Samarth Baviskar", "+234434343434"],
    ["RT", "Ram Tyagi", "+344355767678"],
    ["SM", "Sunil Mishra", "+827878787878"],
  ];

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Your Contact",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: contacts.length,
            itemBuilder: (context, index) {
              final contact = contacts[index];
              return ListTile(
                leading: CircleAvatar(child: Text(contact[0])),
                title: Text(contact[1]),
                subtitle: Text(contact[2]),
                trailing: ElevatedButton(
                  onPressed: () {},
                  child: const Text("Invite"),
                ),
              );
            },
          ),
        ],
      ),
    ),
  );
}

Widget howitworkscard() {
  final steps = [
    [
      "Share Your Referral Link",
      "Send Your Referral Link to your friends and Family",
    ],
    ["They Join the Platform", "When they join the platform, you get a reward"],
    ["Get Rewarded", "Get Rewarded for each friend who joins the platform"],
  ];

  return Card(
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "How it Works",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: steps.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.blue.shade100,
                  child: Text(
                    "${index + 1}",
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),
                title: Text(steps[index][0]),
                subtitle: Text(steps[index][1]),
              );
            },
          ),
        ],
      ),
    ),
  );
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _StatCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.orange, size: 32),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        Text(label, style: const TextStyle(color: Colors.grey)),
      ],
    );
  }
}
