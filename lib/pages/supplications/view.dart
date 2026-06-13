import 'package:flutter/material.dart';

class Supplications extends StatelessWidget {
  const Supplications({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('supplication')),
      body: ViewToggleExample(),
    );
  }
}

class ViewToggleExample extends StatelessWidget {
  const ViewToggleExample({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      // The initialIndex dictates which view starts active
      initialIndex: 0,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              height: 48,
              decoration: BoxDecoration(
                color: Colors.grey.shade200, // The light grey background
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(
                  4.0,
                ), // Padding around the white pill
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  dividerColor: Colors
                      .transparent, // Removes the default Material 3 bottom line
                  splashBorderRadius: BorderRadius.circular(8),
                  // This is the white sliding pill
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  labelColor: const Color(0xFF10b981), // The active green color
                  unselectedLabelColor:
                      Colors.grey.shade600, // The inactive grey color
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Cairo',
                  ), // Use your Arabic font here
                  tabs: const [
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('قائمة'),
                          SizedBox(width: 8),
                          Icon(Icons.format_list_bulleted, size: 20),
                        ],
                      ),
                    ),
                    Tab(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('بطاقات'),
                          SizedBox(width: 8),
                          Icon(Icons.view_carousel_outlined, size: 20),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // The actual content views
          const Expanded(
            child: TabBarView(
              children: [
                Center(child: Text('List View Content (قائمة)')),
                Center(child: Text('Card View Content (بطاقات)')),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
