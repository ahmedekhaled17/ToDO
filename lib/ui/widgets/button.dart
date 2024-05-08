import 'package:flutter/material.dart';
import 'package:todo/ui/theme.dart';

class MyButton extends StatelessWidget {
  const MyButton({Key? key,
    required this.label,
    required this.onTab}) : super(key: key);

  final String label;
  final Function() onTab;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTab,
       child:  Container(
         alignment: Alignment.center,
        height: 45,
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: primaryClr,
        ),
        child: Text(label,style:const TextStyle(
          color: Colors.white,
        ),
            textAlign:TextAlign.center
        ),
        )
      );
  }
}
