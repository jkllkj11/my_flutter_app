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
      home: const MyHomePage(title: '这是我的信息'),
      routes: {
        '/login': (context) => LoginScreen(),
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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _navigateToLogin() {
    Navigator.pushNamed(context, '/login');
  }

  void _showRegistrationSuccessDialog() {
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
  final VoidCallback onRegisterSuccess;

  const FormTestRoute({Key? key, required this.onRegisterSuccess}) : super(key: key);

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
      widget.onRegisterSuccess();
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

                    // 进行登录验证
                    bool loginSuccess = performLogin(username, password);

                    if (loginSuccess) {
                      // 登录成功
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserInfoPage(username: username, password: password),
                        ),
                      );
                    } else {
                      // 登录失败
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text('登录失败'),
                            content: Text('账号或密码错误，请重新输入'),
                            actions: <Widget>[
                              TextButton(
                                child: Text('确定'),
                                onPressed: () {
                                  Navigator.of(context).pop();
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
  }

  bool performLogin(String username, String password) {
    // 进行登录验证的逻辑
    // 根据注册时的用户名和密码进行验证
    // 返回登录结果
    // 这里只是一个示例，实际逻辑需要根据你的需求进行修改

    // 假设注册的用户名为 "admin"，密码为 "password"
    if (username == "admin" && password == "password") {
      return true; // 登录成功
    } else {
      return false; // 登录失败
    }
  }
}

class UserInfoPage extends StatelessWidget {
  final String username;
  final String password;

  const UserInfoPage({Key? key, required this.username, required this.password}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('用户信息'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '用户名: $username',
              style: TextStyle(fontSize: 20),
            ),
            Text(
              '密码: $password',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
