import 'package:augmentalflutter/screens/bottom_navigation/profile/footer/articles_showcase.dart';
import 'package:augmentalflutter/screens/bottom_navigation/profile/footer/portfolio_showcase.dart';
import 'package:augmentalflutter/screens/bottom_navigation/profile/footer/skills_showcase.dart';
import 'package:augmentalflutter/models/augmental_user.dart';
import 'package:flutter/material.dart';

class ProfileShowcase extends StatefulWidget {
  ProfileShowcase(this.friend);

  final AugmentalUser friend;

  @override
  _ProfileShowcaseState createState() => new _ProfileShowcaseState();
}

class _ProfileShowcaseState extends State<ProfileShowcase>
    with TickerProviderStateMixin {
  List<Tab> _tabs;
  List<Widget> _pages;
  TabController _controller;

  @override
  initState() {
    super.initState();
    _tabs = [
      new Tab(text: 'Portfolio'),
      new Tab(text: 'Skills'),
    ];
    _pages = [
      new PortfolioShowcase(),
      new SkillsShowcase(),
    ];
    _controller = new TabController(
      length: _tabs.length,
      vsync: this,
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: new Column(
        children: [
          new TabBar(
            controller: _controller,
            tabs: _tabs,
            indicatorColor: Colors.white,
          ),
          new SizedBox.fromSize(
            size: const Size.fromHeight(300.0),
            child: new TabBarView(
              controller: _controller,
              children: _pages,
            ),
          ),
        ],
      ),
    );
  }
}
