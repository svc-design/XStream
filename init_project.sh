#!/bin/bash

# 初始化 Flutter 项目
echo "Initializing Flutter project structure..."

# 检查是否在 Flutter 项目根目录下
if [ -f "pubspec.yaml" ]; then
    echo "Error: pubspec.yaml already exists. This script is intended for initializing a new project."
    exit 1
fi

# 创建 pubspec.yaml 文件
cat <<EOL > pubspec.yaml
name: xstream
description: A cross-platform network accelerator powered by XTLS VLESS.
version: 1.0.0+1

environment:
  sdk: ">=2.17.0 <3.0.0"

dependencies:
  flutter:
    sdk: flutter
  cupertino_icons: ^1.0.2

dev_dependencies:
  flutter_test:
    sdk: flutter

flutter:
  uses-material-design: true
EOL

echo "pubspec.yaml created."

# 创建目录结构
mkdir -p lib/screens
mkdir -p lib/widgets
mkdir -p lib/utils

# 创建文件并添加基础代码
cat <<EOL > lib/main.dart
import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/subscription_screen.dart';
import 'screens/settings_screen.dart';
import 'utils/app_theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'XStream',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    HomeScreen(),
    SubscriptionScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('XStream'),
      ),
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.link),
            label: 'Subscriptions',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
EOL

cat <<EOL > lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../widgets/custom_list_tile.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        CustomListTile(title: 'VLESS', subtitle: 'tcp | none'),
        CustomListTile(title: 'VMess', subtitle: 'tcp | none'),
        CustomListTile(title: 'Shadowsocks', subtitle: 'tcp | none'),
        CustomListTile(title: 'Trojan', subtitle: 'tcp | tls'),
        CustomListTile(title: 'Socks', subtitle: 'tcp | none'),
      ],
    );
  }
}
EOL

cat <<EOL > lib/screens/subscription_screen.dart
import 'package:flutter/material.dart';
import '../widgets/custom_text_field.dart';

class SubscriptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomTextField(label: 'Name'),
          SizedBox(height: 16),
          CustomTextField(label: 'URL'),
          SizedBox(height: 16),
          Text(
            'Only support https URL, other URL may fail to load',
            style: TextStyle(color: Colors.grey),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Subscription logic
            },
            child: Text('Subscribe'),
          ),
        ],
      ),
    );
  }
}
EOL

cat <<EOL > lib/screens/settings_screen.dart
import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Settings Page'),
    );
  }
}
EOL

cat <<EOL > lib/widgets/custom_list_tile.dart
import 'package:flutter/material.dart';

class CustomListTile extends StatelessWidget {
  final String title;
  final String subtitle;

  CustomListTile({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(Icons.network_check),
      title: Text(title),
      subtitle: Text(subtitle),
      trailing: IconButton(
        icon: Icon(Icons.play_arrow),
        onPressed: () {
          // Connection logic
        },
      ),
    );
  }
}
EOL

cat <<EOL > lib/widgets/custom_text_field.dart
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;

  CustomTextField({required this.label});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}
EOL

cat <<EOL > lib/utils/app_theme.dart
import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData lightTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.light,
  );

  static final ThemeData darkTheme = ThemeData(
    primarySwatch: Colors.blue,
    brightness: Brightness.dark,
  );
}
EOL

echo "Project structure initialized successfully!"
