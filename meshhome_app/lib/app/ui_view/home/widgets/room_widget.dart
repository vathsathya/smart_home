import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class RoomSelector extends StatefulWidget {
  @override
  _RoomSelectorState createState() => _RoomSelectorState();
}

class _RoomSelectorState extends State<RoomSelector> {
  ScrollController _scrollController =
      new ScrollController(initialScrollOffset: 0.0);
  int selectedIndex = 0;
  final List<String> rooms = [
    "All",
    "Bed Room",
    "Living Room",
    "Kitchen",
    "Bath Room",
    "Garden"
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 65,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: rooms.length + 1,
        itemBuilder: (context, index) {
          if (index == rooms.length) {
            return IconButton(
                enableFeedback: true,
                color: Colors.black,
                iconSize: 30.0,
                icon: Icon(AntDesign.ellipsis1),
                onPressed: () {
                  print('object');
                });
          }
          return GestureDetector(
            onTap: () {
              setState(() {
                selectedIndex = index;
              });
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: index == selectedIndex ? Colors.blue : Colors.white,
                    width: index == selectedIndex ? 1.0 : 0.0,
                  ),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                child: Text(
                  rooms[index],
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: index == selectedIndex
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: index == selectedIndex
                          ? Colors.black
                          : Colors.blueGrey),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
