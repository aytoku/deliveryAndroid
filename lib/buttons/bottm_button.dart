import 'package:flutter/material.dart';

class BottomButton extends StatelessWidget {
  final String btnText;

  BottomButton({this.btnText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
          color: Colors.redAccent, borderRadius: BorderRadius.circular(20.0)),
      child: Center(
          child: Row(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(left: 35, right: 35),
                child: Text(
                    'Добавить',
                    style: TextStyle(
                        fontSize: 14.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white
                    )
                ),
              ),
            ],
          )
      ),
    );
  }
}
