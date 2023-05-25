import 'package:demon_idea/pages/check_in/index.dart';
import 'package:demon_idea/pages/video/index.dart';
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
                children: const [
                  CheckInPage(),
                  BasicExamplePage()
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
        width: 80.0,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 20),
                  child: Column(
                    children: const [
                      Icon(
                        Icons.tips_and_updates_outlined,
                        size: 30,
                        color: Colors.black,
                      ),
                    ],
                  )),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: MyIconButtonList(
                  iconDataList: const [
                    Icons.science_outlined,
                    Icons.settings_outlined,
                  ],
                  selectedIndex: currentIndex,
                  onChangeIndex: (int value) {
                    onTap(value);
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  child: IconButton(
                    icon: const Icon(Icons.logout_outlined),
                    onPressed: () {},
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyIconButtonList extends StatefulWidget {
  final int selectedIndex;
  final List<IconData> iconDataList;
  final ValueChanged<int> onChangeIndex;
  MyIconButtonList(
      {super.key,
      required this.iconDataList,
      required this.selectedIndex,
      required this.onChangeIndex});

  @override
  _MyIconButtonListState createState() => _MyIconButtonListState();
}

class _MyIconButtonListState extends State<MyIconButtonList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: widget.iconDataList.asMap().entries.map((entry) {
        final int index = entry.key;
        final IconData iconData = entry.value;
        return Container(
            padding: const EdgeInsets.only(top: 10, bottom: 10),
            child: IconButton(
              icon: Icon(iconData),
              color: widget.selectedIndex == index ? Colors.blue : Colors.grey,
              onPressed: () {
                // 通过回调函数将当前点击的按钮索引传递给父组件
                widget.onChangeIndex(index);
              },
            ));
      }).toList(),
    );
  }
}
