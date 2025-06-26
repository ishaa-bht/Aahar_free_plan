import 'package:flutter/material.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    Color bgColor = isDarkMode ? Colors.black : Color(0xFF1E2A38);
    Color textColor = isDarkMode ? Colors.white : Colors.white;
    Color tileColor = isDarkMode ? Colors.grey[900]! : Color(0xFF253544);

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
        title: Text("My profile", style: TextStyle(color: textColor)),
        centerTitle: true,
      ),
      body: SingleChildScrollView( // ✅ Fixes overflow issue
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Column(
          children: [
            // Profile Header
            Column(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/images/user.png'), // Replace with actual image
                ),
                SizedBox(height: 10),
                Text("Sia", style: TextStyle(color: textColor, fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 4),
                GestureDetector(
                  onTap: () {
                    // Navigate to edit profile
                  },
                  child: Text(
                    "View and edit profile",
                    style: TextStyle(color: Colors.redAccent, fontSize: 14),
                  ),
                ),
              ],
            ),

            SizedBox(height: 30),

            // Account Settings
            _buildListTile(Icons.settings, "Account Settings", tileColor, () {
              // Navigate to account update screen
            }),

            // Ask Question
            _buildListTile(Icons.question_answer, "Ask us a question", tileColor, () {}),

            // Favorites


            // Notifications
            _buildListTile(Icons.notifications, "Notifications", tileColor, () {}),

            // Dark Mode
            Container(
              margin: const EdgeInsets.only(bottom: 10),
              decoration: BoxDecoration(
                color: tileColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: SwitchListTile(
                value: isDarkMode,
                onChanged: (value) {
                  setState(() {
                    isDarkMode = value;
                  });
                },
                title: Text("Dark Mode", style: TextStyle(color: textColor)),
                secondary: Icon(Icons.dark_mode, color: textColor),
                activeColor: Colors.greenAccent,
              ),
            ),

            SizedBox(height: 10),

            // Divider
            Divider(color: Colors.white24),

            // Footer Links
            _buildListTile(Icons.privacy_tip, "Privacy Policy", tileColor, () {}),
            _buildListTile(Icons.article_outlined, "Terms of Use", tileColor, () {}),

            SizedBox(height: 20),

            // Logout
            _buildListTile(Icons.logout, "Logout", tileColor, () {
              // Perform logout
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title, Color tileColor, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: tileColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(icon, color: Colors.white),
        title: Text(title, style: TextStyle(color: Colors.white)),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 16),
        onTap: onTap,
      ),
    );
  }
}
