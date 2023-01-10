import 'dart:math';

import 'package:array_app/array_component.dart';
import 'package:array_app/settings.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: ArrayApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class ArrayApp extends StatefulWidget {
  const ArrayApp({super.key});
  @override
  State<ArrayApp> createState() => _ArrayAppState();
}

class _ArrayAppState extends State<ArrayApp> {
  List<int> _appArray = [1, 2, 3, 4, 5, 6, 7, 8];
  final GlobalKey _draggableKey = GlobalKey();

  int _tempRenders = 1;

  updatedSettings(int newSize) {
    if (newSize == _appArray.length) return;
    final newList = List<int>.generate(
        newSize, (int index) => Random().nextInt(9),
        growable: true);
    setState(() {
      _appArray = newList;
    });
  }

  setNewArray(List<int> newArray) {
    setState(() {
      _appArray = List.from(newArray);
    });

    print("Set new array to $newArray");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F7F7),
      appBar: _buildAppBar(),
      body: Container(padding: const EdgeInsets.all(8), child: _buildContent()),
    );
  }

  Widget _buildContent() {
    return Stack(
      children: [
        SafeArea(
            child: Column(
          children: [
            AppSettings(updateSettingsCallback: updatedSettings),
            Expanded(
              child: ListView.builder(
                itemCount: _tempRenders,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: ArrayComponent(
                      setNewArray: setNewArray,
                      arrayIndex: index + 1,
                      array: _appArray,
                      dragKey: _draggableKey,
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.only(right: 2.5),
                  child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _tempRenders++;
                        });
                      },
                      child: const Text("Add Step")),
                )),
                Expanded(
                    child: Container(
                  padding: const EdgeInsets.only(left: 2.5),
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _tempRenders--;
                      });
                    },
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.red[400])),
                    child: const Text("Remove Step"),
                  ),
                ))
              ],
            )
          ],
        ))
      ],
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      iconTheme: const IconThemeData(color: Color(0xFFF64209)),
      title: Text(
        'Array Visualizer',
        style: Theme.of(context).textTheme.headline4?.copyWith(
              fontSize: 36,
              color: const Color(0xFFF64209),
              fontWeight: FontWeight.bold,
            ),
      ),
      backgroundColor: const Color(0xFFF7F7F7),
      elevation: 0,
    );
  }
}
