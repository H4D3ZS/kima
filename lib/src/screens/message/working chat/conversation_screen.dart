import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:kima/gen/assets.gen.dart';
import 'package:kima/src/data/providers/member_provider.dart';
import 'package:kima/src/screens/message/working%20chat/message_screen.dart';
import 'package:kima/src/screens/message/working%20chat/new_message_screen.dart';
import 'package:kima/src/utils/colors.dart';
import 'package:kima/src/utils/get_user.dart';
import 'package:kima/src/utils/widgets/common/circular_icon_button.dart';

class ConversationListScreen extends StatefulWidget {
  const ConversationListScreen({Key? key}) : super(key: key);

  static const route = '/message';

  @override
  State<ConversationListScreen> createState() => _ConversationListScreenState();
}

class _ConversationListScreenState extends State<ConversationListScreen> {
  List<Map<String, String>> chatRoomDetails = [];
  List<Map<String, String>> searchResults = [];
  final TextEditingController _searchController = TextEditingController();
  MemberProvider memberProvider = MemberProvider();
  List<int> itemsWithDeleteIcon = [];

  late StreamSubscription<QuerySnapshot<Map<String, dynamic>>>
      _chatRoomSubscription;

  Future<String> getOtherUserName(String otherUserId) async {
    // Fetch the other user's name from Firestore using the otherUserId
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(otherUserId)
        .get();

    // Check if the document exists and contains the 'firstName' field
    if (userSnapshot.exists && userSnapshot.data() != null) {
      return userSnapshot['firstName'] + ' ' + userSnapshot['lastName'];
    } else {
      // Return a default value or handle the case where the user data is not found
      return 'Unknown User';
    }
  }

  void startChatRoomListener() {
    _chatRoomSubscription =
        FirebaseFirestore.instance.collection('chatRooms').snapshots().listen(
      (querySnapshot) async {
        chatRoomDetails.clear();
        for (var chatRoom in querySnapshot.docs) {
          List<String> usersIds = chatRoom.id.split('_');

          if (usersIds.contains(getUserId(context))) {
            String otherUserId;

            if (usersIds[0] == usersIds[1]) {
              otherUserId = usersIds[0];
            } else {
              otherUserId =
                  usersIds.firstWhere((id) => id != getUserId(context));
            }

            String otherUserName = await getOtherUserName(otherUserId);

            //if other user id is not same as current user id set to the isHiddenUser2
            bool isHiddenUser1 = chatRoom['isHiddenUser1'];
            bool isHiddenUser2 = chatRoom['isHiddenUser2'];

            Map<String, dynamic> mostRecentMessageDetails =
                await getMostRecentMessageDetails(chatRoom.id);

            // Start listening to messages within this chat room
            startMessagesListener(chatRoom.id);

            setState(() {
              chatRoomDetails.add({
                'chatRoomId': chatRoom.id,
                'otherUserId': otherUserId,
                'otherUserName': otherUserName,
                'mostRecentMessage': mostRecentMessageDetails['message'],
                'formattedTimestamp':
                    mostRecentMessageDetails['formattedTimestamp'],
                'isHiddenUser1': isHiddenUser1.toString(),
                'isHiddenUser2': isHiddenUser2.toString(),
              });
            });
          }
        }
      },
    );
  }

  void startMessagesListener(String chatRoomId) {
    // Listen to changes in the messages collection within this chat room
    FirebaseFirestore.instance
        .collection('chatRooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .limit(1)
        .snapshots()
        .listen((querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        String timestamp = querySnapshot.docs.first['timestamp'];
        String formattedTimestamp =
            DateFormat.jm().format(DateTime.parse(timestamp).toLocal());

        setState(() {
          chatRoomDetails
              .firstWhere(
                (chatRoom) => chatRoom['chatRoomId'] == chatRoomId,
              )
              .update(
                'mostRecentMessage',
                (value) => querySnapshot.docs.first['message'],
              );

          chatRoomDetails
              .firstWhere(
                (chatRoom) => chatRoom['chatRoomId'] == chatRoomId,
              )
              .update(
                'formattedTimestamp',
                (value) => formattedTimestamp,
              );
        });
        // Sort the chat rooms by most recent message
        chatRoomDetails.sort((a, b) {
          return b['formattedTimestamp']!.compareTo(a['formattedTimestamp']!);
        });
      }
    });
  }

  Future<Map<String, dynamic>> getMostRecentMessageDetails(
      String chatRoomId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('chatRooms')
          .doc(chatRoomId)
          .collection('messages')
          .orderBy('timestamp', descending: true)
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        String timestamp = querySnapshot.docs.first['timestamp'];
        String formattedTimestamp =
            DateFormat.jm().format(DateTime.parse(timestamp).toLocal());
        //formatted time with seconds
        // String formattedTimestampWithSeconds =
        //     DateFormat.jms().format(DateTime.parse(timestamp).toLocal());
        // print("formattedTimestampWithSeconds: $formattedTimestampWithSeconds");

        return {
          'message': querySnapshot.docs.first['message'],
          'formattedTimestamp': formattedTimestamp,
          //'formattedTimestampWithSeconds': formattedTimestampWithSeconds,
        };
      } else {
        return {
          'message': 'No messages',
          'formattedTimestamp': '',
          //'formattedTimestampWithSeconds': '',
        };
      }
    } catch (e) {
      print('Error fetching most recent message: $e');
      return {
        'message': 'Error fetching message',
        'formattedTimestamp': '',
        //'formattedTimestampWithSeconds': '',
      };
    }
  }

// Function to check if a member with the given ID already exists in Firestore
  Future<bool> checkMemberExists(String memberId) async {
    DocumentSnapshot memberSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(memberId)
        .get();
    return memberSnapshot.exists;
  }

  // Function to add members to Firestore
  void addMembers() async {
    // Get the members from memberProvider
    memberProvider.getMembers().then((members) {
      // Loop through the members
      members.forEach((member) async {
        // Check if the member with the same ID already exists in Firestore
        bool memberExists = await checkMemberExists(member.id!);
        //print('Member exists: $memberExists');

        if (!memberExists) {
          //Add the member to Firestore
          await FirebaseFirestore.instance
              .collection('users')
              .doc(member.id)
              .set({
            'id': member.id,
            'firstName': member.firstName,
            'lastName': member.lastName,
            'email': member.email,
          });

          // print('Member added with ID: ${member.id}');
          // print('Member added with first name: ${member.firstName}');
          // print('Member added with last name: ${member.lastName}');
          // print('Member added with email: ${member.email}');
        } else {
          //print('Member with ID ${member.id} already exists in Firestore.');
        }
      });
    });
    // Now that members are added, start listening to chat rooms
    startChatRoomListener();
  }

  @override
  void initState() {
    super.initState();
    addMembers();
  }

  @override
  void dispose() {
    _chatRoomSubscription.cancel();
    super.dispose();
  }

  void deleteConversation(String chatRoomId, String currentUserId) async {
    try {
      List<String> usersIds = chatRoomId.split('_');
      if (usersIds.length == 2) {
        String user1 = usersIds[0];
        String user2 = usersIds[1];

        // Update isHiddenUser1 for the current user
        await FirebaseFirestore.instance
            .collection('chatRooms')
            .doc(chatRoomId)
            .update({
          'isHidden${currentUserId == user1 ? 'User1' : 'User2'}': true,
        });

        // Update isHiddenUser2 for the current user
        await FirebaseFirestore.instance
            .collection('chatRooms')
            .doc(chatRoomId)
            .update({
          'isHidden${currentUserId == user2 ? 'User2' : 'User1'}': true,
        });

        //you should also update a field inside all the messages in the chat room
        //to indicate that the conversation is hidden for the current user
        await FirebaseFirestore.instance
            .collection('chatRooms')
            .doc(chatRoomId)
            .collection('messages')
            // .where('senderId', isEqualTo: currentUserId)
            .get()
            .then((querySnapshot) {
          querySnapshot.docs.forEach((doc) {
            //check first if the current user is the sender of the message
            //if yes, then update the isHidden field for the current user
            if (doc['senderId'] == currentUserId) {
              doc.reference.update({
                'isHiddenUser1': true,
              });
            } else if (doc['receiverId'] == currentUserId) {
              doc.reference.update({
                'isHiddenUser2': true,
              });
            }
            // doc.reference.update({
            //   'isHidden${currentUserId == user1 ? 'User1' : 'User2'}': true,
            // });
          });
        });
      }
    } catch (e) {
      print('Error deleting conversation: $e');
      // Handle the error, display a message to the user, etc.
    }
  }

  void updateSearchResults(String searchText) {
    setState(() {
      searchResults = chatRoomDetails
          .where((room) => room['otherUserName']!
              .toLowerCase()
              .contains(searchText.toLowerCase()))
          .toList();
    });
  }

  bool showDeleteIcon = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: GestureDetector(
          onTap: () {
            // //add field for all the messages inside each document id in chatRooms
            // FirebaseFirestore.instance
            //     .collection('chatRooms')
            //     .get()
            //     .then((querySnapshot) {
            //   querySnapshot.docs.forEach((doc) {
            //     FirebaseFirestore.instance
            //         .collection('chatRooms')
            //         .doc(doc.id)
            //         .collection('messages')
            //         .get()
            //         .then((querySnapshot) {
            //       querySnapshot.docs.forEach((doc) {
            //         doc.reference.update({
            //           'isReadUser1': true,
            //           'isReadUser2': true,
            //         });
            //       });
            //     });
            //   });
            // });
          },
          child: const Text(
            'Messages',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        centerTitle: true,
        elevation: 1,
        toolbarHeight: 95.0,
        leadingWidth: 110.0,
        leading: CircularIconButton(
          icon: Assets.icons.iconArrowLeft.svg(),
          bgColor: AppColors.lightGrey20,
          margin: const EdgeInsets.symmetric(horizontal: 30.0),
        //   onTap: () => {
        //   Navigator.maybePop(
        //
        //   )
        // },

          onTap: (){
            Navigator.pop(context);
          },
          // onTap: () {
          //   Navigator.pop(context);
          // },
        ),
        actions: [
          GestureDetector(
              onTap: () => {
                    // _key.currentState!.openEndDrawer()
                    // Navigator.pushNamed(context, NewMessageScreen.route)
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const NewMessageScreen();
                    }))
                  },
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Assets.svg.svgNewMessage.svg(),
              ))
        ],
      ),
      backgroundColor: Colors.white,
      //
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(30),
                child: SizedBox(
                  height: 40,
                  child: TextField(
                    controller: _searchController,
                    onChanged: (value) {
                      updateSearchResults(value);
                    },
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search message or people',
                      hintStyle: const TextStyle(color: AppColors.lightGrey),
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding:
                          const EdgeInsets.symmetric(horizontal: 10),
                      prefixIcon: IconButton(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        icon: Assets.icons.iconSearchMessages.svg(),
                        color: Colors.white,
                        onPressed: () {},
                      ),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          width: 1.0,
                          color: AppColors.lightGrey40,
                        ),
                      ),
                      focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        borderSide: BorderSide(
                          width: 1.0,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: searchResults.isEmpty
                      ? chatRoomDetails.length
                      : searchResults.length,
                  itemBuilder: (context, index) {
                    final currentChatRoom = searchResults.isEmpty
                        ? chatRoomDetails[index]
                        : searchResults[index];

                    String? isHidden = getUserId(context) ==
                            currentChatRoom['chatRoomId']!.split('_')[0]
                        ? currentChatRoom['isHiddenUser1']
                        : currentChatRoom['isHiddenUser2'];

                    return isHidden == "false"
                        ? GestureDetector(
                            onHorizontalDragEnd: (details) {
                              if (details.primaryVelocity! > 0) {
                                print('Swiped from left to right');
                                setState(() {
                                  itemsWithDeleteIcon
                                      .remove(index); // Remove the index
                                });
                              } else if (details.primaryVelocity! < 0) {
                                print('Swiped from right to left');
                                setState(() {
                                  itemsWithDeleteIcon
                                      .add(index); // Add the index
                                });
                              }
                            },
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    margin:
                                        const EdgeInsets.fromLTRB(30, 2, 0, 16),
                                    width: double.infinity,
                                    decoration: const BoxDecoration(
                                      color: AppColors.lightGrey30,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(8)),
                                    ),
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => MessageScreen(
                                              receiverUserId: currentChatRoom[
                                                  'otherUserId']!,
                                              receiverName: currentChatRoom[
                                                  'otherUserName']!,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Row(
                                          children: [
                                            const CircleAvatar(
                                              radius: 27,
                                              backgroundColor:
                                                  Color(0xFFE9E9E9),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Expanded(
                                              child: Column(
                                                children: [
                                                  Row(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          currentChatRoom[
                                                              'otherUserName']!,
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 14,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                          ),
                                                          maxLines: 1,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        currentChatRoom[
                                                            'formattedTimestamp']!,
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 12,
                                                          color: AppColors
                                                              .lightGrey,
                                                        ),
                                                        maxLines: 1,
                                                      ),
                                                    ],
                                                  ),
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          currentChatRoom[
                                                              'mostRecentMessage']!,
                                                          style: GoogleFonts
                                                              .poppins(
                                                                  fontSize: 12,
                                                                  color: AppColors
                                                                      .lightGrey),
                                                          maxLines: 1,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: itemsWithDeleteIcon.contains(index)
                                      ? 15
                                      : 30,
                                ),
                                if (itemsWithDeleteIcon.contains(index))
                                  Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.topRight,
                                      child: GestureDetector(
                                        onTap: () {
                                          // Handle tap on the delete icon
                                          // deleteConversation(
                                          //   currentChatRoom['chatRoomId']!,
                                          //   getUserId(context),
                                          // );
                                          showDeleteConfirmationDialog(context,
                                              currentChatRoom['chatRoomId']!);
                                        },
                                        child: Container(
                                          decoration: const BoxDecoration(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(8)),
                                            color: Color(0xFFD92F58),
                                          ),
                                          margin: const EdgeInsets.fromLTRB(
                                              0, 0, 30, 0),
                                          padding: const EdgeInsets.all(8),
                                          child: const Icon(
                                              Icons.delete_outline_rounded,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          )
                        : const SizedBox.shrink();
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDeleteConfirmationDialog(BuildContext context, String chatRoomId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: const Color(0xFF202020),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF202020),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Padding(
                  padding: EdgeInsets.all(30),
                  child: Text(
                    'Delete this entire conversation?',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      fontFamily: 'Poppins',
                      color: Colors.white, // Change text color if needed
                    ),
                  ),
                ),
                Container(
                  height: 0.25,
                  width: double.infinity,
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Colors.white,
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                    ),
                    //vertical divider
                    Container(
                      height: 60,
                      width: 0.25,
                      color: Colors.white.withOpacity(0.7),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        // Handle tap on the delete button
                        deleteConversation(
                          chatRoomId,
                          getUserId(context),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Delete',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                              color: Color(0xFFD92F58),
                              fontFamily: 'Poppins',
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
