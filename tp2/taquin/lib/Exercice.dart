import 'package:flutter/cupertino.dart';

abstract class Exercice extends StatelessWidget {
  @override
  Widget build(BuildContext context);

  String getTitle();

  String getDescription();
}
