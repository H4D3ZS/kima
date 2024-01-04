import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/screens/message/working%20chat/message_screen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/widgets/common/circular_icon_button.dart';

class User {
  final String userId;
  final String firstName;

  User({required this.userId, required this.firstName});
}

class NewMessageScreen extends StatefulWidget {
  static const route = '/new_message';

  const NewMessageScreen({Key? key}) : super(key: key);

  @override
  State<NewMessageScreen> createState() => _NewMessageScreenState();
}

class _NewMessageScreenState extends State<NewMessageScreen> {
  // List of users
  List<User> users = [];
  List<User> searchResults = [];
  final TextEditingController _searchController = TextEditingController();

  // Get all users in Firestore and display
  void displayUsers() {
    FirebaseFirestore.instance
        .collection('users')
        .get()
        .then((QuerySnapshot querySnapshot) {
      setState(() {
        users = querySnapshot.docs
            .map((doc) => User(
                  userId: doc.id,
                  firstName: doc["firstName"] + ' ' + doc["lastName"],
                ))
            .toList();
      });
    });
  }

  @override
  void initState() {
    super.initState();
    // Call display users
    displayUsers();
  }

  void updateSearchResults(String searchText) {
    setState(() {
      searchResults = users
          .where((user) =>
              user.firstName.toLowerCase().contains(searchText.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          height: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    CircularIconButton(
                      icon: Assets.icons.iconBack.svg(),
                      bgColor: Colors.transparent,
                      onTap: () => {Navigator.pop(context)},
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Text(
                        'New Message',
                        style: GoogleFonts.comfortaa(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(vertical: 15),
                child: Stack(
                  children: [
                    TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        updateSearchResults(value);
                      },
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                      decoration: const InputDecoration(
                        hintText: 'Type a name',
                        hintStyle: TextStyle(color: AppColors.lightGrey),
                        contentPadding:
                            EdgeInsets.only(left: 50, top: 17, bottom: 17),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide(
                            width: 2,
                            color: AppColors.lightGrey30,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          borderSide: BorderSide(
                            width: 2,
                            color: AppColors.lightGrey30,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 17,
                        left: 17,
                        child: Assets.icons.iconSearchMessage.svg())
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 10),
                child: Text('Suggested',
                    style: GoogleFonts.poppins(
                        color: const Color(0xFF757575),
                        fontSize: 18,
                        fontWeight: FontWeight.w700)),
              ),
              Expanded(child: _buildUserList()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserList() {
    final displayList = searchResults.isNotEmpty ? searchResults : users;

    return ListView.builder(
      itemCount: displayList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MessageScreen(
                  receiverUserId: displayList[index].userId,
                  receiverName: displayList[index].firstName,
                ),
              ),
            );
          },
          child: ListTile(
            leading: const CircleAvatar(
              child: CircleAvatar(backgroundColor: Color(0xFFE9E9E9)),
            ),
            title: Text(displayList[index].firstName),
          ),
        );
      },
    );
  }
}
