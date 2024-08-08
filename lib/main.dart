import 'package:flutter/material.dart';
import 'package:interview_flutter/components/custom_appbar.dart';
import 'package:interview_flutter/components/tab_bar.dart';
import 'package:interview_flutter/providers/list_provider.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ListProvider()),
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Material App',
        home: Scaffold(
          resizeToAvoidBottomInset: true,
          appBar: PreferredSize(preferredSize: Size(double.infinity, 64), child: CustomAppBar()),
          body: TabBarCustom(),
        ),
      ),
    );
  }
}




