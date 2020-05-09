import 'package:flutter/material.dart';

class Bottom extends StatefulWidget{

  _BottomState createState()=>_BottomState();
}

class _BottomState extends State<Bottom>{

  String _selectedItem = '';
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
              RaisedButton(
                child: Text('Show'),
                onPressed: ()=> _onPressedButton(),
              ),
            Text(_selectedItem, style: TextStyle(fontSize: 20),)
          ],
        ),
      ),
    );
  }


  void _onPressedButton(){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return Container(
            color: Color(0xFF737373),
            height: 180,
            child:  Container(
              child: _buildBottomNavigationMenu(),
                decoration: BoxDecoration(
                    color: Theme.of(context).canvasColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(10),
                      topRight: const Radius.circular(10),
                    )
                ),
            )
          );
    });
  }

  Column _buildBottomNavigationMenu(){
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.ac_unit),
          title: Text('Cooling'),
          onTap: ()=>_selectItem('Cooling'),
        ),
        ListTile(
          leading: Icon(Icons.accessibility_new),
          title: Text('People'),
          onTap: ()=>_selectItem('People'),
        ),
      ],
    );
  }

  void _selectItem(String name){
    Navigator.pop(context);
    setState(() {
      _selectedItem = name;
    });
  }
}