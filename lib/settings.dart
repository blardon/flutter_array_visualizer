import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class AppSettings extends StatefulWidget {
  const AppSettings({super.key, required this.updateSettingsCallback});

  final Function updateSettingsCallback;

  @override
  State<AppSettings> createState() => _AppSettingsState();
}

class _AppSettingsState extends State<AppSettings> {
  int _arraySizeValue = 8;
  bool _midEnabled = false;

  onSliderChanged(int value) {
    setState(() {
      _arraySizeValue = value;
    });
    widget.updateSettingsCallback(_arraySizeValue);
  }

  onMidSwitchToggled() {
    setState(() {
      _midEnabled = !_midEnabled;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Array Size: $_arraySizeValue",
              style: const TextStyle(fontSize: 22, height: 1.0),
            ),
            Expanded(
              child: Slider(
                min: 1,
                max: 20,
                value: _arraySizeValue.toDouble(),
                onChanged: (value) => onSliderChanged(value.round()),
              ),
            )
          ],
        ),
        /*Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Text(
                  "Enable Mid Pointer ",
                  style: const TextStyle(fontSize: 22, height: 1.0),
                ),
                Switch(
                  value: _midEnabled,
                  onChanged: (value) {
                    onMidSwitchToggled();
                  },
                )
              ],
            ),
            ElevatedButton(onPressed: () {}, child: Text("Reset All Pointer"))
          ],
        ),*/
        Row(
          children: [
            Text(
              "Legend: ",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.arrow_upward_rounded,
                        color: Colors.red,
                      ),
                      Text(" Left Pointer")
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.arrow_upward_rounded,
                        color: Colors.black,
                      ),
                      Text(" Mid Pointer")
                    ],
                  ),
                  Row(
                    children: const [
                      Icon(
                        Icons.arrow_upward_rounded,
                        color: Colors.blue,
                      ),
                      Text(" Right Pointer")
                    ],
                  )
                ],
              ),
            )
          ],
        ),
        const Divider()
      ],
    );
  }
}
