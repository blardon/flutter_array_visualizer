import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ArrayElement extends StatelessWidget {
  const ArrayElement({
    super.key,
    required this.arrayValue,
    required this.arrayIndex,
    required this.dragKey,
    required this.isBehindArrow,
    required this.onValueChange,
    required this.controller,
  });

  final int arrayValue;
  final int arrayIndex;
  final GlobalKey dragKey;
  final bool isBehindArrow;
  final Function onValueChange;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: LongPressDraggable<int>(
        data: arrayValue,
        feedback:
            DraggingArrayElement(dragKey: dragKey, elementValue: arrayValue),
        dragAnchorStrategy: pointerDragAnchorStrategy,
        child: Opacity(
          opacity: isBehindArrow ? 0.35 : 1.0,
          child: Material(
            elevation: 2.5,
            borderRadius: BorderRadius.circular(5.0),
            color: Colors.white,
            child: Center(
              child: TextField(
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                expands: true,
                minLines: null,
                maxLines: null,
                onChanged: (value) {
                  int? newValue = int.tryParse(value);
                  if (newValue != null) {
                    onValueChange(arrayIndex, newValue);
                  }
                },
                controller: controller,
                keyboardType:
                    const TextInputType.numberWithOptions(signed: true),
                decoration: const InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.zero,
                    border: InputBorder.none),
                style: const TextStyle(
                    fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              /*Text(
                "$array_value",
                style: const TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
              ),*/
            ),
          ),
        ),
      ),
    );
  }
}

class DraggingArrayElement extends StatelessWidget {
  const DraggingArrayElement(
      {super.key, required this.dragKey, required this.elementValue});

  final GlobalKey dragKey;
  final int elementValue;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: Container(
        key: dragKey,
        height: 100,
        width: 100,
        child: Material(
          elevation: 2.5,
          borderRadius: BorderRadius.circular(18.0),
          color: Colors.white,
          child: Center(
            child: Text(
              "$elementValue",
              style: const TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
