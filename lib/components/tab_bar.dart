import 'package:flutter/material.dart';
import 'package:interview_flutter/components/body_content.dart';

class TabBarCustom extends StatefulWidget {
  const TabBarCustom({
    super.key,
  });

  @override
  State<TabBarCustom> createState() => _TabBarCustomState();
}

class _TabBarCustomState extends State<TabBarCustom>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: const [
              BodyContent(idx: 1),
              BodyContent(idx: 2),
              BodyContent(idx: 3),
            ],
          ),
        ),
        TabBar(
          controller: _tabController,
          labelColor: Colors.blue,
          tabs: const [
            Tab(
              icon: Icon(Icons.home_outlined),
            ),
            Tab(
              icon: Icon(Icons.location_on_outlined),
            ),
            Tab(
              icon: Icon(Icons.person_outline),
            ),
          ],
        ),
      ],
    );
  }
}
