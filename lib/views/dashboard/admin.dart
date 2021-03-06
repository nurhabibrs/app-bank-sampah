import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../services/user_api_auth.dart';
import '../welcome/welcome.dart';
import '../../extensions/hidden_keyboard.dart';

class AdminDashboard extends StatefulWidget {
  final String token;
  final AsyncSnapshot snapshot;
  const AdminDashboard({
    Key? key,
    required this.token,
    required this.snapshot,
  }) : super(key: key);

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

final ApiServices apiServices = ApiServices();

class _AdminDashboardState extends State<AdminDashboard> {
  List<String> listNameUser = [];
  Future<Map<String, dynamic>> getAllUserData() async {
    dynamic response = await apiServices.getAllUserData(widget.token);
    return response;
  }

  Future activateUser(value, token, name) async {
    var dio = Dio();

    try {
      // Check response
      await dio
          .post(
        'https://345d-103-23-224-196.ap.ngrok.io/admin/profile/update/$name',
        data: {'is_active': value},
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            Headers.contentTypeHeader: 'application/json'
          },
        ),
      )
          .then(
        (response) {
          if (response.data['response']['new_profile']['is_active'] == 1) {
            SnackBar snackBar = const SnackBar(
              content: Text("Aktifkan user berhasil."),
              duration: Duration(seconds: 1),
              backgroundColor: Color.fromARGB(255, 50, 205, 50),
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          } else {
            SnackBar snackBar = const SnackBar(
              content: Text("Nonaktifkan user berhasil."),
              duration: Duration(seconds: 1),
              backgroundColor: Colors.red,
            );
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }
        },
      );
    } on DioError catch (err) {
      return err.message;
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            "Aktivasi User",
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 50, 205, 50),
          actions: [
            IconButton(
              onPressed: () {
                showSearch(
                  context: context,
                  delegate:
                      MySearch(token: widget.token, listNameUser: listNameUser),
                );
              },
              icon: const Icon(Icons.search),
            ),
          ],
        ),
        drawer: NavigationDrawer(
          snapshot: widget.snapshot,
          token: widget.token,
        ),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          // physics: const BouncingScrollPhysics(),
          child: HiddenKeyboard(
            child: SizedBox(
              width: size.width,
              child: FutureBuilder<Map<String, dynamic>>(
                future: getAllUserData(),
                builder: (context, snapshotAllUser) {
                  if (snapshotAllUser.connectionState ==
                      ConnectionState.waiting) {
                    return SizedBox(
                      height: size.height,
                      width: size.width,
                      child: const Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.blue,
                          ),
                          strokeWidth: 6,
                        ),
                      ),
                    );
                  }
                  if (snapshotAllUser.hasData) {
                    return Container(
                      width: size.width,
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const ScrollPhysics(),
                            itemCount: snapshotAllUser.data!['response']
                                        ['total_items'] >
                                    snapshotAllUser.data!['response']
                                        ['items_per_page']
                                ? snapshotAllUser.data!['response']
                                    ['items_per_page']
                                : snapshotAllUser.data!['response']
                                    ['total_items'],
                            itemBuilder: (context, index) {
                              String username = snapshotAllUser
                                  .data!['response']['data'][index]['username'];
                              String fullname = snapshotAllUser
                                  .data!['response']['data'][index]['fullname'];
                              String phone = snapshotAllUser.data!['response']
                                  ['data'][index]['phone'];
                              int isActive = snapshotAllUser.data!['response']
                                  ['data'][index]['is_active'];
                              listNameUser.add(username);
                              // print(listNameUser);
                              // print(username);
                              // print(isActive);

                              return Card(
                                color: const Color.fromARGB(255, 225, 235, 236),
                                child: Padding(
                                  padding: const EdgeInsets.all(5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Flexible(
                                            child: ListTile(
                                              leading: const SizedBox(
                                                height: double.infinity,
                                                child: Icon(Icons
                                                    .account_circle_rounded),
                                              ),
                                              title: Text(username),
                                              subtitle: Text(
                                                  'NAMA LENGKAP\n$fullname\nNOMOR TELEPON\n$phone'),
                                            ),
                                          ),
                                          TextButton.icon(
                                            style: TextButton.styleFrom(
                                              backgroundColor: isActive == 0
                                                  ? Colors.red
                                                  : const Color.fromARGB(
                                                      255, 50, 205, 50),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                              ),
                                            ),
                                            onPressed: () => {
                                              if (isActive == 0)
                                                {
                                                  activateUser(1, widget.token,
                                                      username),
                                                }
                                              else
                                                {
                                                  activateUser(0, widget.token,
                                                      username),
                                                }
                                            },
                                            icon: Icon(
                                                isActive == 0
                                                    ? Icons.cancel_sharp
                                                    : Icons.check_circle,
                                                color: Colors.white),
                                            label: isActive == 0
                                                ? const Text(
                                                    'Nonaktif',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  )
                                                : const Text(
                                                    'Aktif',
                                                    style: TextStyle(
                                                        color: Colors.white),
                                                  ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  } else {
                    // debugPrint(snapshotAllUser.error.toString());
                  }
                  return const SizedBox();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class NavigationDrawer extends StatefulWidget {
  final String token;
  final AsyncSnapshot snapshot;
  const NavigationDrawer({
    Key? key,
    required this.snapshot,
    required this.token,
  }) : super(key: key);
  @override
  State<NavigationDrawer> createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            buildHeader(context),
            buildItems(context),
          ],
        ),
      ),
    );
  }

  Widget buildHeader(BuildContext context) {
    String username =
        widget.snapshot.data!["response"]["user_info"]["username"];
    String email = widget.snapshot.data!["response"]["user_info"]["email"];
    return Container(
      color: const Color.fromARGB(255, 50, 205, 50),
      padding: EdgeInsets.only(
        top: 10 + MediaQuery.of(context).padding.top,
        bottom: 10,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(5),
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Container(
              height: 100,
              width: 100,
              clipBehavior: Clip.hardEdge,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
              ),
              child: const Image(
                  image: AssetImage('assets/images/trash.png'),
                  fit: BoxFit.cover),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            username,
            style: const TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
          ),
          Text(
            email,
            style: const TextStyle(fontSize: 15, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget buildItems(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Wrap(
        children: [
          ListTile(
            leading: const SizedBox(
              height: double.infinity,
              child: Icon(Icons.settings_outlined),
            ),
            title: const Text("Pengaturan"),
            onTap: () {},
          ),
          const Divider(
            height: 5,
            thickness: 2,
          ),
          ListTile(
            leading: const SizedBox(
              height: double.infinity,
              child: Icon(Icons.logout_outlined),
            ),
            title: const Text("Logout"),
            onTap: () async {
              await apiServices.logout(widget.token);
              if (!mounted) return;
              Navigator.of(context)
                  .pushReplacementNamed(WelcomeScreen.nameRoute);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class MySearch extends SearchDelegate {
  String token;
  List<String> listNameUser;

  MySearch({required this.token, required this.listNameUser});

  Future<Map<String, dynamic>> searchData(query) async {
    dynamic response = await apiServices.searchUserData(token, query);
    return response;
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, null);
      },
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
    );
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          // if (query.isEmpty) {
          query = '';
          close(context, null);
          // } else {}
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    Future activateUser(value, token, name) async {
      var dio = Dio();

      try {
        // Check response
        await dio
            .post(
          'https://345d-103-23-224-196.ap.ngrok.io/admin/profile/update/$name',
          data: {'is_active': value},
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              Headers.contentTypeHeader: 'application/json'
            },
          ),
        )
            .then(
          (response) {
            if (response.data['response']['new_profile']['is_active'] == 1) {
              SnackBar snackBar = const SnackBar(
                content: Text("Aktivasi user berhasil."),
                duration: Duration(seconds: 1),
                backgroundColor: Color.fromARGB(255, 50, 205, 50),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              SnackBar snackBar = const SnackBar(
                content: Text("Nonaktivasi user berhasil."),
                duration: Duration(seconds: 1),
                backgroundColor: Color.fromARGB(255, 50, 205, 50),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            }
          },
        );
      } on DioError catch (err) {
        return err.message;
      }
    }

    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      child: FutureBuilder<Map<String, dynamic>>(
        future: searchData(query),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(
              height: size.height,
              width: size.width,
              child: const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Colors.blue,
                  ),
                  strokeWidth: 6,
                ),
              ),
            );
          }
          if (snapshot.hasData &&
              snapshot.data!['response'] != 'User not found') {
            String username = snapshot.data!['response']['user']['username'];
            String fullname = snapshot.data!['response']['user']['fullname'];
            String phone = snapshot.data!['response']['user']['phone'];
            int isActive = snapshot.data!['response']['user']['is_active'];
            return Container(
              width: size.width,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Card(
                    color: const Color.fromARGB(255, 225, 235, 236),
                    child: Padding(
                      padding: const EdgeInsets.all(5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Flexible(
                                child: ListTile(
                                  leading: const SizedBox(
                                    height: double.infinity,
                                    child: Icon(Icons.account_circle_rounded),
                                  ),
                                  title: Text(username),
                                  subtitle: Text(
                                      'NAMA LENGKAP\n$fullname\nNOMOR TELEPON\n$phone'),
                                ),
                              ),
                              TextButton.icon(
                                style: TextButton.styleFrom(
                                  backgroundColor: isActive == 0
                                      ? Colors.red
                                      : const Color.fromARGB(255, 50, 205, 50),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(24.0),
                                  ),
                                ),
                                onPressed: () => {
                                  if (isActive == 0)
                                    {
                                      activateUser(1, token, username),
                                      isActive = 1
                                    }
                                  else
                                    {
                                      activateUser(0, token, username),
                                      isActive = 0
                                    }
                                },
                                icon: Icon(
                                    isActive == 0
                                        ? Icons.cancel_sharp
                                        : Icons.check_circle,
                                    color: Colors.white),
                                label: isActive == 0
                                    ? const Text(
                                        'Nonaktif',
                                        style: TextStyle(color: Colors.white),
                                      )
                                    : const Text(
                                        'Aktif',
                                        style: TextStyle(color: Colors.white),
                                      ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            debugPrint(snapshot.error.toString());
          }
          return const SizedBox();
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final recentUsers = [];
    final suggestionList = query.isEmpty
        ? recentUsers
        : listNameUser.where((element) => element.startsWith(query)).toList();

    return ListView.builder(
      itemCount: suggestionList.length,
      itemBuilder: (context, index) {
        return ListTile(
          leading: const Icon(Icons.account_circle_rounded),
          title: RichText(
            text: TextSpan(
              text: suggestionList[index].substring(0, query.length),
              style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: suggestionList[index].substring(query.length),
                  style: const TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),
          onTap: () {
            query = suggestionList[index];
            showResults(context);
          },
        );
      },
    );
  }
}
