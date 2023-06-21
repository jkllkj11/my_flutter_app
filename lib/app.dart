import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const MyHomePage(title: '这是我的信息'),
        '/login': (context) => LoginScreen(),
        '/userInfo': (context) => UserInfoPage(),
      },
    );
  }
}


class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String? registeredUsername;
  String? registeredPassword;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _navigateToLogin() {
    Navigator.pushNamed(context, '/login', arguments: {
      'registeredUsername': registeredUsername,
      'registeredPassword': registeredPassword,
    });
  }

  void _showRegistrationSuccessDialog(String username, String password) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('注册成功'),
          content: Text('您已成功注册！'),
          actions: <Widget>[
            TextButton(
              child: Text('立即登录'),
              onPressed: () {
                Navigator.pop(context); // 关闭对话框
                _navigateToLogin(); // 跳转到登录页面
              },
            ),
            TextButton(
              child: Text('稍后登录'),
              onPressed: () {
                Navigator.pop(context); // 关闭对话框
              },
            ),
          ],
        );
      },
    );
    registeredUsername = username;
    registeredPassword = password;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FormTestRoute(
              onRegisterSuccess: _showRegistrationSuccessDialog,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class FormTestRoute extends StatefulWidget {
  final Function(String, String) onRegisterSuccess;

  const FormTestRoute({Key? key, required this.onRegisterSuccess})
      : super(key: key);

  @override
  _FormTestRouteState createState() => _FormTestRouteState();
}

class _FormTestRouteState extends State<FormTestRoute> {
  TextEditingController _unameController = TextEditingController();
  TextEditingController _pwdController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _register() {
    if (_formKey.currentState!.validate()) {
      // 验证通过提交数据
      // 模拟注册成功
      String username = _unameController.text;
      String password = _pwdController.text;
      widget.onRegisterSuccess(username, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: <Widget>[
          TextFormField(
            autofocus: true,
            controller: _unameController,
            decoration: InputDecoration(
              labelText: "用户名",
              hintText: "用户名或邮箱",
              icon: Icon(Icons.person),
            ),
            validator: (v) {
              return v!.trim().isNotEmpty ? null : "用户名不能为空";
            },
          ),
          TextFormField(
            controller: _pwdController,
            decoration: InputDecoration(
              labelText: "密码",
              hintText: "您的登录密码",
              icon: Icon(Icons.lock),
            ),
            obscureText: true,
            validator: (v) {
              return v!.trim().length > 5 ? null : "密码不能少于6位";
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: ElevatedButton(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text("注册"),
                    ),
                    onPressed: _register,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    if (arguments != null) {
      final String registeredUsername = arguments['registeredUsername'];
      final String registeredPassword = arguments['registeredPassword'];

      bool performLogin(String username, String password) {
        // 进行登录验证，比较输入的用户名和密码与保存的注册信息是否相同
        return username == registeredUsername && password == registeredPassword;
      }

      return Scaffold(
        appBar: AppBar(
          title: Text('登录'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                controller: _usernameController,
                decoration: InputDecoration(
                  labelText: "用户名",
                  hintText: "请输入注册时的用户名",
                  icon: Icon(Icons.person),
                ),
              ),
              TextFormField(
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: "密码",
                  hintText: "请输入注册时的密码",
                  icon: Icon(Icons.lock),
                ),
                obscureText: true,
              ),
              SizedBox(height: 20), // 添加一个间距
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: 200.0, // 设置按钮宽度
                  height: 50.0, // 设置按钮高度
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(0), // 移除内边距
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.0),
                      ),
                      primary: Colors.red,
                      onPrimary: Colors.white,
                      shadowColor: Colors.black54,
                      elevation: 4.0,
                    ),
                    child: Text("登录"),
                    onPressed: () {
                      // 获取输入的用户名和密码
                      String username = _usernameController.text;
                      String password = _passwordController.text;

                      if (performLogin(username, password)) {
                        // 登录成功，跳转到用户信息页面并传递用户名和密码
                        Navigator.pushNamed(context, '/userInfo', arguments: {
                          'username': username,
                          'password': password,
                        });
                      } else {
                        // 登录失败，显示错误提示
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('登录失败'),
                              content: Text('用户名或密码不正确'),
                              actions: <Widget>[
                                TextButton(
                                  child: Text('确定'),
                                  onPressed: () {
                                    Navigator.pop(context); // 关闭对话框
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('登录'),
        ),
        body: Center(
          child: Text('未提供注册信息'),
        ),
      );
    }
  }
}
class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
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

