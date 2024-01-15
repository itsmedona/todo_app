import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:to_do_app/model/NoteModel/NoteModel.dart';
import 'package:to_do_app/view/HomeScreen/HomeScreen_Widget/HomeScreen_Widget.dart';

class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  var box = Hive.box<NoteModel>('myBox');
  final nameController = TextEditingController();
  final desController = TextEditingController();
  final dateController = TextEditingController();
  final updatenameController = TextEditingController();
  final updatedesController = TextEditingController();
  final updatedateController = TextEditingController();
  List<NoteModel> myNoteList = [];
  List<Color> myColors = [
    Colors.redAccent,
    Colors.lightBlueAccent,
    Colors.lightGreenAccent,
    Colors.purpleAccent,
  ];

  int? selectedIndex;
  var keyList = [];

  @override
  void initState() {
    keyList = box.keys.toList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 15, 52, 101),
        appBar: AppBar(
          elevation: 0,
          title: Text(
            "My Notes...!!",
            style: TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
          ),
          backgroundColor: Colors.blueGrey,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView.separated(
            separatorBuilder: (context, index) => SizedBox(height: 20),
            itemCount: keyList.length,
            itemBuilder: (context, index) => HomeScreenWidget(
              color: myColors[box.get(keyList[index])!.color],
              title: box.get(keyList[index])!.title,
              description: box.get(keyList[index])!.description,
              date: box.get(keyList[index])!.date,
              ondeletetap: () {
                box.delete(keyList.removeAt(index));
                setState(() {});
              },
              onsharetap: () {
                String noteText = "Title: ${box.get(keyList[index])!.title}\n"
                    "Description: ${box.get(keyList[index])!.description}\n"
                    "Date: ${box.get(keyList[index])!.date}";

                Share.share(
                  noteText,
                  subject: "My Note",
                );
              },
              onedittap: () {
                showModalBottomSheet(
                  context: context,
                  builder: (context) {
                    return StatefulBuilder(
                        builder: (context, CsetState) => Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                TextField(
                                  controller: updatenameController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "New Title"),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  controller: updatedesController,
                                  decoration: InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: "New Description"),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                TextField(
                                  controller: updatedateController,
                                  decoration: InputDecoration(
                                      icon: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 0),
                                        child: Icon(Icons.calendar_today),
                                      ), //icon of text field
                                      labelText: "New Date"),
                                  readOnly:
                                      true, //set it true, so that user will not able to edit text
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context,
                                        initialDate: DateTime.now(),
                                        firstDate: DateTime(
                                            2000), //DateTime.now() - not to allow to choose before today.
                                        lastDate: DateTime(2101));

                                    if (pickedDate != null) {
                                      print(
                                          "pickedDate: $pickedDate"); //pickedDate output format => 2021-03-10 00:00:00.000
                                      String formattedDate =
                                          DateFormat('yyyy-MM-dd')
                                              .format(pickedDate);
                                      print("formattedDate: $formattedDate");
                                      setState(() {
                                        updatedateController.text =
                                            formattedDate; //set output date to TextField value.
                                      });
                                    } else {
                                      SnackBar(
                                        content: Text("Select Date"),
                                      );
                                    }
                                  },
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
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
                                                    color: myColors[index]
                                                        .withOpacity(.5),
                                                    width: 5)
                                                : null,
                                            color:
                                                myColors[index].withOpacity(.4),
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
                                    onPressed: () {
                                      box.put(
                                          keyList[index],
                                          NoteModel(
                                              title: updatenameController.text,
                                              date: updatedateController.text,
                                              description:
                                                  updatedesController.text,
                                              color: selectedIndex!));
                                      setState(() {});
                                      keyList =
                                          box.keys.toList(); // get keys from db
                                      print("update key list: $keyList");

                                      updatenameController.clear();
                                      updatedesController.clear();
                                      updatedateController.clear();
                                      Navigator.pop(context);
                                    },
                                    child: Text("Save"))
                              ],
                            ));
                  },
                );
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: Color.fromARGB(210, 121, 79, 45),
            onPressed: () {
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
              builder: (context, C2setState) => Column(
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
                      TextField(
                        controller: dateController,
                        decoration: InputDecoration(
                            icon: Padding(
                              padding: const EdgeInsets.only(right: 0),
                              child: Icon(Icons.calendar_today),
                            ),
                            labelText: "Date"),
                        readOnly: true,
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(2000),
                              lastDate: DateTime(2101));

                          if (pickedDate != null) {
                            print("pickedDate: $pickedDate");
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print("formattedDate: $formattedDate");
                            setState(() {
                              dateController.text = formattedDate;
                            });
                          } else {
                            SnackBar(
                              content: Text("Select Date"),
                            );
                          }
                        },
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

                              C2setState(() {});
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
                          onPressed: () {
                            box.add(NoteModel(
                                title: nameController.text,
                                date: dateController.text,
                                description: desController.text,
                                color: selectedIndex!));
                            setState(() {});
                            keyList = box.keys.toList(); // get keys from db
                            print("key list: $keyList");

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
/*
class Homescreen extends StatefulWidget {
  const Homescreen({super.key});

  @override
  State<Homescreen> createState() => _HomescreenState();
}

class _HomescreenState extends State<Homescreen> {
  final nameController = TextEditingController();
  final desController = TextEditingController();
  final dateController = TextEditingController();
  final updateNameController = TextEditingController();
  final updateDesController = TextEditingController();
  final updateDateController = TextEditingController();
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
    myNoteList = await getNotes();
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
            itemBuilder: (context, index) {
              return HomeScreenWidget(
                color: myColors[myNoteList[index].color],
                title: myNoteList[index].title,
                description: myNoteList[index].description,
                date: myNoteList[index].date!,
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
              );
            },
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
                        style: TextStyle(color: Colors.black),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Date",
                          suffixIcon: InkWell(
                            onTap: () {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2050),
                              ).then((pickedDate) {
                                if (pickedDate != null) {
                                  dateController.text = pickedDate
                                      .toLocal()
                                      .toString()
                                      .split(' ')[0];
                                }
                              });
                            },
                            child: Icon(Icons.calendar_today),
                          ),
                        ),
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
                            //if (selectedIndex != null) {
                            await dbNotes.insertNote(NoteModel(
                              id: null,
                              title: nameController.text,
                              date: dateController.text,
                              description: desController.text,
                              color: selectedIndex!,
                            ));
                            await _loadNotes();

                            setState(() {});
                            //print(nameController.text);
                            //print(desController.text);
                            nameController.clear();
                            desController.clear();
                            dateController.clear();
                            Navigator.pop(context);
                            // }
                          },
                          child: Text("Save"))
                    ],
                  ));
        });
  }

  getNotes() {}
}*/
