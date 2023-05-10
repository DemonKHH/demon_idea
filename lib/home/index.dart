import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;
  PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Row(
        children: [
          NavigationDrawer(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
              _pageController.jumpToPage(index);
            },
          ),
          Expanded(
            child: Container(
              clipBehavior: Clip.antiAlias,
              margin: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: const Color(0xFFE5E7F0),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 8.0,
                    spreadRadius: 1.0,
                    offset: const Offset(0, 1),
                  ),
                ],
              ),
              child: PageView(
                controller: _pageController,
                children: [
                  Container(
                    child: const Center(
                      child: Text(
                        '页面 1',
                        style: TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.green,
                    child: const Center(
                      child: Text(
                        '页面 2',
                        style: TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.blue,
                    child: const Center(
                      child: Text(
                        '页面 3',
                        style: TextStyle(
                          fontSize: 36.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
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

class NavigationDrawer extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const NavigationDrawer(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100.0,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.red,
                child: Center(
                  child: Text(
                    '顶部',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Container(
                color: Colors.green,
                child: Center(
                  child: Text(
                    '中间',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                color: Colors.blue,
                child: Center(
                  child: Text(
                    '底部',
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        // child: ListView(
        //   children: [
        //     ListTile(
        //       title: const Text('页面 1'),
        //       selected: currentIndex == 0,
        //       onTap: () => onTap(0),
        //     ),
        //     ListTile(
        //       title: const Text('页面 2'),
        //       selected: currentIndex == 1,
        //       onTap: () => onTap(1),
        //     ),
        //     ListTile(
        //       title: const Text('页面 3'),
        //       selected: currentIndex == 2,
        //       onTap: () => onTap(2),
        //     ),
        //   ],
        // ),
      ),
    );
  }
}
