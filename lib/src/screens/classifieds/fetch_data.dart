// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:kima/src/screens/marketplace/marketplace/ClassifiedModels.dart';


// Future<ClassifiedData> fetchClassifiedData(String jwtToken) async {
//   final apiUrl = 'http://localhost:5000/classifieds?page=1&id=1';

//   try {
//     final response = await http.get(
//       Uri.parse(apiUrl),
//       headers: {'Authorization': 'Bearer $jwtToken'},
//     );

//     if (response.statusCode == 200) {
//       final Map<String, dynamic> data = json.decode(response.body);

//       // Assuming that the "data" field contains the list of classifieds
//       final List<dynamic> classifiedsList = data['data'];

//       if (classifiedsList.isNotEmpty) {
//         final classifiedData = classifiedsList[0];
//         return ClassifiedData.fromJson(classifiedData);
//       } else {
//         throw Exception('No classified data available');
//       }
//     } else {
//       throw Exception(
//           'Failed to load classified data - ${response.statusCode}');
//     }
//   } catch (e) {
//     throw Exception('Error: $e');
//   }
// }
