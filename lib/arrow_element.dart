import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

enum ArrowSide { left, mid, right }

class ArrowElement extends StatelessWidget {
  const ArrowElement(
      {super.key,
      required this.handleDragStart,
      required this.handleDragEnd,
      required this.atIndex,
      required this.dragKey,
      required this.active,
      required this.sides});

  final int atIndex;
  final GlobalKey dragKey;
  final bool active;
  final Function handleDragStart;
  final Function handleDragEnd;
  final List<String> sides;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FittedBox(
          child: sides.isNotEmpty
              ? Column(
                  children: [
                    ...sides.map((side) {
                      if (side == "mid") {
                        return _buildDragTargetItem(side);
                      } else {
                        return LongPressDraggable<String>(
                            data: side,
                            delay: const Duration(milliseconds: 0),
                            dragAnchorStrategy: pointerDragAnchorStrategy,
                            feedback: DraggingArrowElement(
                                dragKey: dragKey, indexValue: atIndex),
                            child: _buildDragTargetItem(side));
                      }
                    }).toList(),
                    Text(
                      "Idx: $atIndex",
                      style: const TextStyle(fontSize: 7),
                    )
                  ],
                )
              : _buildDragTargetItem(null)),
      /*child: active && sides.isNotEmpty
          ? Column(
              children: sides.map((side) {
                print(sides);
                return LongPressDraggable<String>(
                  data: side,
                  hapticFeedbackOnStart: true,
                  delay: const Duration(milliseconds: 0),
                  onDragStarted: () => handleDragStart(atIndex),
                  feedback: DraggingArrowElement(
                      dragKey: dragKey, indexValue: atIndex),
                  dragAnchorStrategy: pointerDragAnchorStrategy,
                  child: _buildDragTargetItem(active),
                );
              }).toList(),
            )
          : _buildDragTargetItem(active),
    */
    );
  }

  Widget _buildDragTargetItem(String? side) {
    return DragTarget<String>(
        onAccept: (data) => handleDragEnd(data, atIndex),
        builder: (context, candidateData, rejectedData) {
          return FittedBox(
            child: Opacity(
              opacity: candidateData.isNotEmpty ? 0.2 : 1,
              child: Icon(
                Icons.arrow_upward_rounded,
                color: side != null || candidateData.isNotEmpty
                    ? getArrowColor(side)
                    : Colors.transparent,
              ),
            ),
          );
        });
  }

  Color getArrowColor(String? side) {
    if (side == "left")
      return Colors.red;
    else if (side == "right")
      return Colors.blue;
    else if (side == "mid")
      return Colors.black;
    else
      return Colors.grey;
  }
}

class DraggingArrowElement extends StatelessWidget {
  const DraggingArrowElement(
      {super.key, required this.dragKey, required this.indexValue});

  final GlobalKey dragKey;
  final int indexValue;

  @override
  Widget build(BuildContext context) {
    return FractionalTranslation(
      translation: const Offset(-0.5, -0.5),
      child: Container(
        key: dragKey,
        height: 100,
        width: 100,
        child: Center(
            child: Icon(
          Icons.arrow_upward_rounded,
          size: 76.0,
          color: Colors.black45,
        )),
      ),
    );
  }
}
