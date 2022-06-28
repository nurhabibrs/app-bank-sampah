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

class _AdminDashboardState extends State<AdminDashboard> {
  final ApiServices _apiServices = ApiServices();

  Future<Map<String, dynamic>> getAllUserData() async {
    dynamic response = await _apiServices.getAllUserData(widget.token);
    return response;
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SizedBox(
      width: size.width,
      height: size.height,
      child: Scaffold(
        appBar: // PreferredSize(
            //   preferredSize: const Size.fromHeight(80),
            AppBar(
          centerTitle: true,
          // toolbarHeight: 80,
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
                showSearch(context: context, delegate: MySearch());
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
                                ['items_per_page'],
                            itemBuilder: (context, index) {
                              String username = snapshotAllUser
                                  .data!['response']['data'][index]['username'];
                              String fullname = snapshotAllUser
                                  .data!['response']['data'][index]['fullname'];
                              String phone = snapshotAllUser.data!['response']
                                  ['data'][index]['phone'];
                              // var isActive = snapshotAllUser.data!['response']
                              //     ['data'][index]['is_active'];

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
                                              backgroundColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(24.0),
                                              ),
                                            ),
                                            onPressed: () => {},
                                            icon: const Icon(
                                              Icons.check_rounded,
                                            ),
                                            label: const Text(
                                              'Aktif',
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
                    debugPrint(snapshotAllUser.error.toString());
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
  final ApiServices _apiServices = ApiServices();
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
      padding: const EdgeInsets.all(10),
      child: Wrap(
        runSpacing: 16,
        children: [
          ListTile(
            title: const Text("Pengaturan"),
            onTap: () {},
          ),
          ListTile(
            title: const Text("Logout"),
            onTap: () async {
              await _apiServices.logout(widget.token);
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
  final users = ["Ana", "Abi", "Andara"];

  final recentUsers = ["Bintang", "Candra", "Dela"];

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
          if (query.isEmpty) {
            close(context, null);
          } else {}
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget buildResults(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 100,
        width: 100,
        child: Card(
          color: Colors.red,
          child: Center(
            child: Text(query),
          ),
        ),
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty
        ? recentUsers
        : users.where((element) => element.startsWith(query)).toList();

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
            showResults(context);
          },
        );
      },
    );
  }
}
