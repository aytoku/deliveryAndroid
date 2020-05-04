import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  final String btnText;

  Button({this.btnText});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50.0,
      decoration: BoxDecoration(
          color: Colors.redAccent, borderRadius: BorderRadius.circular(8.0)),
      child: Center(
        child: Row(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '30 – 50 мин',
                style: TextStyle(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),),
            ),
            Padding(
              padding: EdgeInsets.only(left: 35),
              child: Text(
                  'Оплатить',
                  style: TextStyle(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white
                  )
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 50, right: 5),
              child:  Text(
                "$btnText",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.0,
                ),
              ),
            ),
          ],
        )
      ),
    );
  }
}
