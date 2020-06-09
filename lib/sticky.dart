import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:food_delivery/screens/AttachCardScreen.dart';
import 'package:sticky_headers/sticky_headers/widget.dart';


class SliversBasicPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          //pinned: true,
          floating: false,
          pinned: true,
          expandedHeight: 120.0,
          flexibleSpace: FlexibleSpaceBar(
            title: Text('Basic Slivers'),
          ),
        ),

        SliverList(
          delegate: SliverChildBuilderDelegate(
                (context, index) {
              return Container(
                height: 50,
                alignment: Alignment.center,
                color: Colors.orange[100 * (index % 9)],
                child: Text('orange $index'),
              );
            },
            childCount: 20,
          ),
        ),
      ],
    );
  }
}