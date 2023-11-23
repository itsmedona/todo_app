import 'package:flutter/material.dart';
import 'package:to_do_app/model/NoteModel/NoteModel.dart';
import 'package:to_do_app/view/HomeScreen/HomeScreen_Widget/HomeScreen_Widget.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final nameController = TextEditingController();
  final desController = TextEditingController();
  final dateController = TextEditingController();
  List<NoteModel> myNoteList = [
    /////seperate model class
    NoteModel(title: " ", date: " ", description: "  ", color: 3),
  ];
  List<Color> MyColors = [
    Colors.red,
    Colors.lightGreen,
    Colors.purpleAccent,
    Colors.orangeAccent
  ];
  String value = "";
  int? selectedIndex;
  List<int> selectedList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ToDo App...."),
        backgroundColor: Color.fromARGB(255, 8, 227, 125),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: ListView.builder(
          itemCount: myNoteList.length,
          itemBuilder: (context, index) => SizedBox(
            height: 200,
            width: 300,
            child: HomeScreenWidget(
                //created widget
                onDeletetap: () {
                  myNoteList.removeAt(
                      index); //for deleting it from the widget declaration and here
                  setState(() {});
                },
                title: myNoteList[index].title,
                description: myNoteList[index].description,
                date: myNoteList[index].date,
                color: MyColors[myNoteList[index].color],
                onedittap: () {
                  value = "Update";

                  nameController.text = myNoteList[index].title;
                  desController.text = myNoteList[index].description;
                  //dateController.text = myNoteList[index].date;
                }),
          ),
        ),
      ),
    );
    /*floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Color(0xffEBE3D5)),
                        child: TextField(
                          controller: nameController,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(), hintText: "Title"),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 50),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffEBE3D5)),
                      child: TextField(
                        controller: desController,
                        decoration: InputDecoration(
                            border: InputBorder.none, hintText: "Description"),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Color(0xffEBE3D5)),
                      child: TextField(
                        controller: dateController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: "date"),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        InkWell(
                            child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 107, 230, 111),
                              borderRadius: BorderRadius.circular(20)),
                        )),
                        SizedBox(
                          width: 15,
                        ),
                        InkWell(
                            child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 243, 173, 62),
                              borderRadius: BorderRadius.circular(20)),
                        )),
                        SizedBox(
                          width: 15,
                        ),
                        InkWell(
                            child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 123, 218, 237),
                              borderRadius: BorderRadius.circular(20)),
                        )),
                        SizedBox(
                          width: 15,
                        ),
                        InkWell(
                            child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 236, 146, 202),
                              borderRadius: BorderRadius.circular(20)),
                        )),
                        SizedBox(
                          width: 15,
                        ),
                        InkWell(
                            child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 240, 96, 96),
                              borderRadius: BorderRadius.circular(20)),
                        )),
                        SizedBox(
                          width: 15,
                        ),
                        InkWell(
                            child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 172, 76, 227),
                              borderRadius: BorderRadius.circular(20)),
                        )),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          myNoteList.add(NoteModel(
                              title: nameController.text,
                              date: dateController.text,
                              description: desController.text));
                          setState(() {});
                          nameController.clear();
                          desController.clear();
                          dateController.clear();
                          Navigator.pop(context);
                        },
                        child: Text("Save"))
                  ],
                ),
              ),
            ),
          );
        },
        child: Icon(Icons.add),
      ),*/
  }
}
