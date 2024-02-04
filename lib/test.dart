import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_infinity_app/enxrypt.dart';

class TestPage extends StatefulWidget {
  const TestPage({Key? key}) : super(key: key);

  @override
  State<TestPage> createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            var name = Encryption.instance.encrypt({
              'user': 'Mohammad',
              'userId': 72,
            }).toString();
            debugPrint(name);
            var name2 = Encryption.instance.decrypt(name).toString();
            var test = Encryption.instance.decrypt('or69NDS3UGLEfyTMDoA6/KNBw8dBrAuIPBCYnlXcMt8A/GAoS/HydmSH8VSKrv4T4nzq+cFHyVnjrddfrFxqIQ==').toString();
            debugPrint(test);
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }
}
