import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeScreenWidget extends StatelessWidget {
  HomeScreenWidget(
      {super.key,
      required this.title,
      required this.description,
      required this.date,
      required this.ondeletetap,
      required this.onsharetap,
      this.onedittap,
      required this.color});
  final String title;
  final String description;
  final String date;
  final VoidCallback? ondeletetap;
  final VoidCallback? onedittap;
  final VoidCallback? onsharetap;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Card(
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
                    title,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      InkWell(onTap: ondeletetap, child: Icon(Icons.delete)),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(onTap: onedittap, child: Icon(Icons.edit))
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    description,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                InkWell(onTap: onsharetap, child: Icon(Icons.share)),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  date,
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
        color: color,
  ),
);
}
}