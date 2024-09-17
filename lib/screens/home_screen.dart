import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:nina_homework/model/firestore_model.dart';
import 'package:nina_homework/model/user_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirestoreService firestoreService = FirestoreService();
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isObscured = true;

  void openDialogBox({String? userId}) {
    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) {
          return AlertDialog(
            content: Form(
              key: formkey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Email'),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                    controller: emailController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.all(8),
                      isDense: true,
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text('Password'),
                  TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Required';
                      }
                      return null;
                    },
                    controller: passwordController,
                    obscureText: isObscured,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(8),
                      isDense: true,
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        icon: Icon(
                          isObscured ? Icons.visibility : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            isObscured = !isObscured;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    final userModel = UserModel(
                      email: emailController.text,
                      password: passwordController.text,
                      profile: ProfileModel(
                        followers: '-',
                        watchtime: '-',
                        badges: '-',
                      ),
                    );
                    if (userId == null) {
                      firestoreService.addUser(userModel);
                    } else {
                      firestoreService.updateUser(userId, userModel);
                    }
                    emailController.clear();
                    passwordController.clear();
                    Navigator.pop(context);
                  }
                },
                child: const Text(
                  'Done',
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          stream: firestoreService.getUserStream(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text('error'),
              );
            } else if (snapshot.hasData) {
              List userList = snapshot.data!.docs;
              return ListView.separated(
                padding: const EdgeInsets.all(10),
                itemBuilder: (context, index) {
                  DocumentSnapshot document = userList[index];
                  Map<String, dynamic> data =
                      document.data() as Map<String, dynamic>;
                  String userId = document.id;
                  return Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Email : ${data['Email']}',
                              ),
                              Text(
                                'Password : ${data['Password']}',
                              ),
                              const Text(
                                'Profile : ',
                              ),
                              Text(
                                ' - Follower List : ${data['Profile']['Followers']}',
                              ),
                              Text(
                                ' - Watchtime : ${data['Profile']['Watchtime']}',
                              ),
                              Text(
                                ' - Badges : ${data['Profile']['Badges']}',
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          children: [
                            IconButton(
                              onPressed: () {
                                firestoreService.deleteUser(userId);
                              },
                              icon: const Icon(
                                Icons.delete,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                openDialogBox(userId: userId);
                              },
                              icon: const Icon(
                                Icons.edit,
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: userList.length,
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
      floatingActionButton: IconButton(
        onPressed: () async {
          openDialogBox();
        },
        icon: Container(
          padding: const EdgeInsets.all(20),
          decoration: const BoxDecoration(
            color: Color(0xFF9147FF),
            shape: BoxShape.circle,
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
