import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeScreenWidget extends StatefulWidget {
  HomeScreenWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.date,
      this.onedittap,
      this.onDeletetap,
      required this.color});
  final String title;
  final String description;
  final String? date;
  final VoidCallback? onDeletetap;
  final VoidCallback? onedittap;
  Color color;

  @override
  State<HomeScreenWidget> createState() => _HomeScreenWidgetState();
}

class _HomeScreenWidgetState extends State<HomeScreenWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    InkWell(
                        onTap: widget.onDeletetap, child: Icon(Icons.delete)),
                    SizedBox(
                      width: 20,
                    ),
                    InkWell(onTap: widget.onedittap, child: Icon(Icons.edit)),
                  ],
                )
              ],
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.description,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Positioned(
                  top: 0,
                  bottom: 10,
                  right: 20,
                  child: Text(
                    "",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                    ),
                    ],
          )
        ],
      ),
      color: widget.color,
    );
  }
}
