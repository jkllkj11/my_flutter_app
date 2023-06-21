import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ScaffoldRoute(),
    );
  }
}

class ScaffoldRoute extends StatefulWidget {
  @override
  _ScaffoldRouteState createState() => _ScaffoldRouteState();
}

class _ScaffoldRouteState extends State<ScaffoldRoute> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('App'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/OIP (1).jpg'), // 替换为你的图片路径
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            Wrap(
              alignment: WrapAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('全部'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(300, 40), // 设置按钮的宽度和高度
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('男生'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(325, 40), // 设置按钮的宽度和高度
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('女生'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(325, 40), // 设置按钮的宽度和高度
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('更多'),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(325, 40), // 设置按钮的宽度和高度
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'images/OIP (2).jpg',
                            width: 200,
                            height: 200,
                          ),
                          Text('红楼梦'),
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'images/OIP (3).jpg',
                            width: 200,
                            height: 200,
                          ),
                          Text('三国演义'),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'images/OIP.jpg',
                            width: 200,
                            height: 200,
                          ),
                          Text('白蔷会'),
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset(
                            'images/R1.png',
                            width: 200,
                            height: 200,
                          ),
                          Text('水浒传'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '书架',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: '更多',
          ),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
