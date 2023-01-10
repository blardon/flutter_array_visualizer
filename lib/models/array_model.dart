import 'dart:math';

class ArrayModel {
  late List<int> theArray;

  late int leftPointer;
  late int rightPointer;

  ArrayModel(int length) {
    final newList = List<int>.generate(
        length, (int index) => Random().nextInt(9),
        growable: true);
    theArray = newList;

    leftPointer = 0;
    rightPointer = theArray.length - 1;
  }
}
