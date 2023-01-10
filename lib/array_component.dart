import 'package:array_app/array_element.dart';
import 'package:array_app/arrow_element.dart';
import 'package:flutter/material.dart';

class ArrayComponent extends StatefulWidget {
  const ArrayComponent(
      {super.key,
      required this.arrayIndex,
      required this.array,
      required this.dragKey,
      required this.setNewArray});

  final List<int> array;
  final int arrayIndex;
  final GlobalKey dragKey;
  final Function setNewArray;

  @override
  State<ArrayComponent> createState() => _ArrayComponentState();
}

class _ArrayComponentState extends State<ArrayComponent> {
  late int _leftArrowIndex;
  late int _rightArrowIndex;
  late int _midArrowIndex;

  @override
  initState() {
    super.initState();

    _leftArrowIndex = 0;
    _rightArrowIndex = widget.array.length - 1;

    _midArrowIndex = calcMidArrowIndex();
  }

  int calcMidArrowIndex() {
    return (_leftArrowIndex + (_rightArrowIndex - _leftArrowIndex) / 2).toInt();
  }

  arrayValueChange(int index, int newValue) {
    widget.array[index] = newValue;
    widget.setNewArray(widget.array);
  }

  startedDrag(int index) {
    print("Started dragging $index");
  }

  endedDrag(String? side, int index) {
    print("Ended dragging on $index on side $side");
    setState(() {
      if (side == "left") {
        _leftArrowIndex = index;
      } else if (side == "right") {
        _rightArrowIndex = index;
      }
      _midArrowIndex = calcMidArrowIndex();
    });
  }

  List<String> getSidesForIdx(int idx) {
    List<String> res = [];
    if (idx == _leftArrowIndex) res.add("left");
    if (idx == _midArrowIndex) res.add("mid");
    if (idx == _rightArrowIndex) res.add("right");
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Material(
          elevation: 10.0,
          borderRadius: BorderRadius.circular(15),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.only(left: 12, bottom: 8, top: 0),
                  child: Text(
                    "Array ${widget.arrayIndex}",
                    style: const TextStyle(
                        fontSize: 18.0,
                        height: 1.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  height: constraints.maxWidth / widget.array.length,
                  child: Row(
                    children: widget.array.asMap().entries.map((entry) {
                      int idx = entry.key;
                      int val = entry.value;
                      TextEditingController controller =
                          TextEditingController(text: "$val");
                      controller.selection = TextSelection.fromPosition(
                          TextPosition(offset: controller.text.length));
                      return ArrayElement(
                        arrayValue: val,
                        arrayIndex: idx,
                        dragKey: widget.dragKey,
                        onValueChange: arrayValueChange,
                        controller: controller,
                        isBehindArrow:
                            _leftArrowIndex > idx || _rightArrowIndex < idx,
                      );
                    }).toList(),
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.array.asMap().entries.map((entry) {
                    int idx = entry.key;
                    int val = entry.value;

                    if (_rightArrowIndex > widget.array.length - 1) {
                      _rightArrowIndex = widget.array.length - 1;
                    }

                    if (_leftArrowIndex > widget.array.length - 1) {
                      _leftArrowIndex = 0;
                    }

                    _midArrowIndex = calcMidArrowIndex();

                    return ArrowElement(
                      active: idx == _leftArrowIndex ||
                          idx == _rightArrowIndex ||
                          idx == _midArrowIndex,
                      sides: getSidesForIdx(idx),
                      atIndex: idx,
                      dragKey: widget.dragKey,
                      handleDragStart: startedDrag,
                      handleDragEnd: endedDrag,
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
