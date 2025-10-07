import 'package:flutter/material.dart';
import 'package:my_cst2322_labs/data_repository.dart';
import 'package:my_cst2322_labs/profile_page.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lab 5 Login Page',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => const MyHomePage(title: 'Lab 5 Login Page'),
        '/profile': (context) => const ProfilePage(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late TextEditingController _loginController;
  late TextEditingController _passwordController;
  final EncryptedSharedPreferences _prefs = EncryptedSharedPreferences();

  @override
  void initState() {
    super.initState();
    _loginController = TextEditingController();
    _passwordController = TextEditingController();
  }

  void _onLoginPressed() async {
    if (_passwordController.text == "abcd") {
      DataRepository.loginName = _loginController.text;
      await DataRepository.loadData();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Welcome Back ${DataRepository.loginName}")),
      );

      Navigator.pushNamed(context, "/profile");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Incorrect password")),
      );
    }
  }

  @override
  void dispose() {
    _loginController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _loginController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Login name",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                ),
              ),
            ),
            ElevatedButton(
              onPressed: _onLoginPressed,
              child: const Text("Login"),
            ),
          ],
        ),
      ),
    );
  }
}
