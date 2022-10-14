// ignore_for_file: file_names
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:temp/EnterAmount.dart';
import 'package:temp/ScanQR.dart';
import "package:flutter/services.dart" as s;
import 'package:temp/utils/navbar.dart';
import "package:yaml/yaml.dart";
import 'main.dart';

class User {
  late String name;
  late String userLoginId;
  User(this.name, this.userLoginId);
}

List<User> li = [];

dynamic getUserfromQuery(String query) async {
  String yamlString = await s.rootBundle.loadString("lib/config.yaml");
  links = loadYaml(yamlString);
  var url = links['host'] + links['search'] + query;
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final jsonResponse = jsonDecode(response.body);
    var u = jsonResponse['users'];
    li.clear();
    if (query == "" || query == null) {
      return;
    }
    for (int i = 0; i < u.length; i++) {
      User obj = User(u[i]["name"], u[i]["user_login_id"]);
      if (u[i]["name"] != uname) {
        li.add(obj);
      }
    }
  }
}

// CREATING A STATEFUL WIDGET HERE
class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  int c = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      
    //  backgroundColor: Colors.transparent,
      drawer: const Navbar(),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_outlined,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            );
          },
        ),
        backgroundColor: Colors.transparent,
        title: Image.asset(
          "assets/images/RakutenPay.png",
//          "assets/images/RakutenPay.jpg",
          fit: BoxFit.cover,
          height: 30,
        ),
      ),
      
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/image.jpeg"),
       //       alignment: Alignment(-0.6 + (0.1 * activeIndex), 1),
              // (activeIndex == 0)
              //     ? Alignment(-0.6 + (0.1 * activeIndex), 1)
              //     : const Alignment(-0.5, 1),
              fit: BoxFit.cover,
            ),
          ),
          ),
          // adding the searchbar code here 
          Container(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 15.0,right: 15.0,top: 85.0),
              child: Autocomplete<User>(
                optionsBuilder: (TextEditingValue textEditingValue) {
                  for (int i = 0; i < li.length; i++) {
                    if (li[i].name == uname.toString()) {
                      li.remove(li[i]);
                    }
                  }
                  return li
                      .where((User user) => user.name
                          .toLowerCase()
                          .startsWith(textEditingValue.text.toLowerCase()))
                      .toList();
                },
                displayStringForOption: (User option) => option.name,
                fieldViewBuilder: (BuildContext context,
                    TextEditingController fieldTextEditingController,
                    FocusNode fieldFocusNode,
                    VoidCallback onFieldSubmitted) {
                      
                  return TextField(
                    controller: fieldTextEditingController,
                    focusNode: fieldFocusNode,
                    onChanged: (query) async {
                      await getUserfromQuery(query.toString());
                      setState(() {});
                    },
                    
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.search,color: Colors.white,),
                      enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white)),
                      focusedBorder: OutlineInputBorder(borderSide: const BorderSide(color: Colors.white)),
                      labelText: 'Search for User',
                      labelStyle: TextStyle(color: Colors.white),
                      hintText: 'Enter User Name / Rakuten Pay ID',
                      hintStyle: TextStyle(color: Colors.white),
                      prefixIconColor: Colors.white,
                      focusColor: Colors.white
                      
                    ),
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                  );
                },
                onSelected: (User selection) {
                  receiverName = selection.name;
                  receiverUid = selection.userLoginId;
                },
                optionsViewBuilder: (BuildContext context,
                    AutocompleteOnSelected<User> onSelected,
                    Iterable<User> options) {
                  return Align(
                    alignment: Alignment.topLeft,
                    child: Material(
                      child: Container(
                        child: Scrollbar(
                          child: ListView.builder(
                    
                            padding: const EdgeInsets.all(10.0),
                            itemCount: options.length,
                            itemBuilder: (BuildContext context, int index) {
                              final User option = options.elementAt(index);
                              return GestureDetector(
                  
                                onTap: () {
                                  onSelected(option);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const EnterAmount()),
                                  );
                                },
                                child: ListTile(
                                  tileColor: Colors.transparent,
                                  title: Text(option.name,
                                      style:
                                          const TextStyle(color: Colors.black)),
                                ),
                              );
                            },
                          ),
                          isAlwaysShown: false,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
        ],
      ),
      // body: Container(
      //   child: Column(
      //     children: <Widget>[
      //       Padding(
      //         padding: const EdgeInsets.all(15.0),
      //         child: Autocomplete<User>(
      //           optionsBuilder: (TextEditingValue textEditingValue) {
      //             for (int i = 0; i < li.length; i++) {
      //               if (li[i].name == uname.toString()) {
      //                 li.remove(li[i]);
      //               }
      //             }
      //             return li
      //                 .where((User user) => user.name
      //                     .toLowerCase()
      //                     .startsWith(textEditingValue.text.toLowerCase()))
      //                 .toList();
      //           },
      //           displayStringForOption: (User option) => option.name,
      //           fieldViewBuilder: (BuildContext context,
      //               TextEditingController fieldTextEditingController,
      //               FocusNode fieldFocusNode,
      //               VoidCallback onFieldSubmitted) {
      //             return TextField(
      //               controller: fieldTextEditingController,
      //               focusNode: fieldFocusNode,
      //               onChanged: (query) async {
      //                 await getUserfromQuery(query.toString());
      //                 setState(() {});
      //               },
      //               decoration: const InputDecoration(
      //                 prefixIcon: Icon(Icons.search),
      //                 border: OutlineInputBorder(),
      //                 labelText: 'Search for User',
      //                 hintText: 'Enter User Name / Rakuten Pay ID',
      //               ),
      //               style: const TextStyle(fontWeight: FontWeight.bold),
      //             );
      //           },
      //           onSelected: (User selection) {
      //             receiverName = selection.name;
      //             receiverUid = selection.userLoginId;
      //           },
      //           optionsViewBuilder: (BuildContext context,
      //               AutocompleteOnSelected<User> onSelected,
      //               Iterable<User> options) {
      //             return Align(
      //               alignment: Alignment.topLeft,
      //               child: Material(
      //                 child: Container(
      //                   child: Scrollbar(
      //                     child: ListView.builder(
      //                       padding: const EdgeInsets.all(10.0),
      //                       itemCount: options.length,
      //                       itemBuilder: (BuildContext context, int index) {
      //                         final User option = options.elementAt(index);
      //                         return GestureDetector(
      //                           onTap: () {
      //                             onSelected(option);
      //                             Navigator.push(
      //                               context,
      //                               MaterialPageRoute(
      //                                   builder: (context) =>
      //                                       const EnterAmount()),
      //                             );
      //                           },
      //                           child: ListTile(
      //                             title: Text(option.name,
      //                                 style:
      //                                     const TextStyle(color: Colors.black)),
      //                           ),
      //                         );
      //                       },
      //                     ),
      //                     isAlwaysShown: false,
      //                   ),
      //                 ),
      //               ),
      //             );
      //           },
      //         ),
      //       ),
      //     ],
      //   ),
      // ),
      //change 1 
      floatingActionButton: Container(
        padding: const EdgeInsets.only(bottom: 100.0),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: FloatingActionButton.extended(
            heroTag: "hero8",
            backgroundColor: Colors.red,
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ScanQrPage()));
            },
            icon: const Icon(Icons.qr_code_2),
            label: const Text("Pay using QR"),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
