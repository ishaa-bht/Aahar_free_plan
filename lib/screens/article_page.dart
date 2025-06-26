import 'package:flutter/material.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.share, color: Colors.black),
            onPressed: () {
              // Add share functionality
            },
          ),
          IconButton(
            icon: Icon(Icons.bookmark_border, color: Colors.black),
            onPressed: () {
              // Add bookmark functionality
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Article category and date
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.redAccent.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    "NUTRITION",
                    style: TextStyle(
                      color: Colors.redAccent,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                Spacer(),
                Text(
                  "5 min read • Dec 15, 2024",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),

            SizedBox(height: 20),

            // Article title
            Text(
              "The Pros and Cons of Packaged Food",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
                height: 1.3,
              ),
            ),

            SizedBox(height: 10),

            // Article subtitle
            Text(
              "Understanding the impact of processed foods on your health and lifestyle choices",
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[700],
                height: 1.4,
              ),
            ),

            SizedBox(height: 25),

            // Article image
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                image: DecorationImage(
                  image: AssetImage('assets/images/packed_food.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            SizedBox(height: 25),

            // Article content
            _buildSectionTitle("The Convenience Factor"),
            _buildParagraph(
                "Packaged foods have revolutionized the way we eat, offering unprecedented convenience in our fast-paced lives. From ready-to-eat meals to snack bars, these products save time and effort in meal preparation."
            ),

            _buildSectionTitle("Pros of Packaged Food"),
            _buildBulletPoint("🕒 Time-saving and convenient"),
            _buildBulletPoint("📅 Longer shelf life and reduced food waste"),
            _buildBulletPoint("🛡️ Enhanced food safety through processing"),
            _buildBulletPoint("🌍 Accessibility and consistent availability"),
            _buildBulletPoint("💰 Often more cost-effective"),

            SizedBox(height: 20),

            _buildSectionTitle("Cons of Packaged Food"),
            _buildBulletPoint("🧂 High sodium and preservative content"),
            _buildBulletPoint("🍬 Added sugars and artificial ingredients"),
            _buildBulletPoint("📉 Lower nutritional density"),
            _buildBulletPoint("🌱 Environmental packaging concerns"),
            _buildBulletPoint("💸 Hidden costs in long-term health"),

            SizedBox(height: 20),

            _buildSectionTitle("Making Informed Choices"),
            _buildParagraph(
                "The key to incorporating packaged foods into a healthy diet lies in reading labels carefully and choosing products with minimal processing. Look for items with fewer ingredients, lower sodium content, and no added sugars."
            ),

            _buildParagraph(
                "Balance is essential - while packaged foods can be part of a modern lifestyle, they shouldn't replace fresh, whole foods entirely. Use our barcode scanner to check the nutritional information of products before making your purchase decisions."
            ),

            SizedBox(height: 30),

            // Call-to-action card
            Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Color(0xFFF8F9FA),
                borderRadius: BorderRadius.circular(15),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.qr_code_scanner,
                    size: 40,
                    color: Colors.green,
                  ),
                  SizedBox(height: 15),
                  Text(
                    "Ready to make informed choices?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Use our barcode scanner to get instant nutritional insights on any packaged product.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 14,
                    ),
                  ),
                  SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context); // Go back to home
                      // You can add navigation to scan page here if needed
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Start Scanning",
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(width: 8),
                        Icon(Icons.arrow_forward, color: Colors.white, size: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: EdgeInsets.only(top: 20, bottom: 12),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
      ),
    );
  }

  Widget _buildParagraph(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 15),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[800],
          height: 1.6,
        ),
      ),
    );
  }

  Widget _buildBulletPoint(String text) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 16,
          color: Colors.grey[800],
          height: 1.5,
        ),
      ),
    );
  }
}