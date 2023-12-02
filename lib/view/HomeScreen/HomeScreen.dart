import 'package:flutter/material.dart';
import 'package:to_do_app/controller/Database/Database.dart';
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
    // Notemodel(title: "title", date: "date", description: "des", color: 3)
  ];
  List<Color> myColors = [
    Colors.redAccent,
    Colors.lightBlueAccent,
    Colors.lightGreenAccent,
    Colors.purpleAccent,
  ];
  String value = "";
  //int? checkvalue;
  int? selectedIndex;
  List<int> selectedList = [];

  final dbNotes = DatabaseNotes();

  @override
  void initState() {
    super.initState();
    _loadNotes();
  }

  Future<void> _loadNotes() async {
    myNoteList = await dbNotes.getNotes();
    setState(() {});
  }

  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text("ToDo App....."),
            backgroundColor: Colors.deepPurpleAccent),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 20),
            itemCount: myNoteList.length,
            itemBuilder: (context, index) => HomeScreenWidget(
              color: myColors[myNoteList[index].color],
              title: myNoteList[index].title,
              description: myNoteList[index].description,
              date: myNoteList[index].date,
              onDeletetap: () {
                myNoteList.removeAt(index);
                setState(() {});
              },
              onedittap: () {
                value = "Update";
                bottomSheet(context);
                nameController.text = myNoteList[index].title;
                desController.text = myNoteList[index].description;
                dateController.text = myNoteList[index].date!;
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              value = "submit";
              selectedIndex = null;
              bottomSheet(context);
            },
            child: Icon(Icons.add)));
  }

  Future<dynamic> bottomSheet(BuildContext context) {
    return showModalBottomSheet(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, CsetState) => Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(), hintText: "Title"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextField(
                        controller: desController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Description"),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        controller: dateController,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Date",
                            suffixIcon: InkWell(
                              onTap: () {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(2000),
                                  lastDate: DateTime(2101),
                                ).then((pickedDate) {
                                  if (pickedDate != null) {
                                    dateController.text = pickedDate
                                        .toLocal()
                                        .toString()
                                        .split('')[0];
                                  }
                                });
                              },
                              child: Icon(Icons.calendar_today),
                            )),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(
                          myColors.length,
                          (index) => InkWell(
                            onTap: () {
                              selectedIndex = index;
                              CsetState(() {});
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                height: 50,
                                width: 50,
                                decoration: BoxDecoration(
                                  border: selectedIndex == index
                                      ? Border.all(
                                          color:
                                              myColors[index].withOpacity(.5),
                                          width: 5)
                                      : null,
                                  color: myColors[index].withOpacity(.4),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      ElevatedButton(
                          onPressed: () async {
                            dbNotes.insertNote(NoteModel(
                               id: null,
                              title: nameController.text,
                              date: dateController.text,
                              description: desController.text,
                              color: selectedIndex!,
                            ));
                            await _loadNotes();


                            //setState(() {});
//print(nameController.text);
                            //print(desController.text);
                            nameController.clear();
                            desController.clear();
                            dateController.clear();
                            Navigator.pop(context);
                          },
                          child: Text("Save"))
                    ],
                  ));
        });
  }
}
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