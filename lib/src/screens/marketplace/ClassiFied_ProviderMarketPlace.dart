import 'package:kima/src/data/models/classifieds_model.dart';



class ClassifiedProviderMarketPlace {
  Future<List<Classified>> getClassifieds() async {
    // Dummy data example for a list of members
    List<Map<String, dynamic>> memberListData = [
      {
        "id": 1,
        "createdAt": "2023-12-30T15:01:32.219Z",
        "updatedAt": "2023-12-30T15:01:32.219Z",
        "category": "events",
        "title": "Free Robux",
        "location": "unahan sa apoopng",
        "description": "sample description 1",
        "eventDetails": {
          "eventType": "paid",
          "date": "2023-12-30",
          "time": "10:30",
          "tickets": [
            {
              "title": "ticket 1",
              "price": 10
            },
            {
              "title": "ticket 2",
              "price": 20
            }
          ]
        },
        "jobPostingDetails": {
          "sections": [
            {
              "title": "section 1",
              "description": "section description 1"
            },
            {
              "title": "section 2",
              "description": "section description 2"
            }
          ]
        },
        "forSaleDetails": {
          "price": 100,
          "itemCondition": "new"
        }
      },
      {
        "id": 2,
        "createdAt": "2023-12-30T15:02:45.123Z",
        "updatedAt": "2023-12-30T15:02:45.123Z",
        "category": "jobs",
        "title": "sample title 2",
        "location": "sample location 2",
        "description": "sample description 2",
        "eventDetails": {
          "eventType": "free",
          "date": "2023-12-31",
          "time": "14:00",
          "tickets": [
            {
              "title": "free ticket",
              "price": 0
            }
          ]
        },
        "jobPostingDetails": {
          "sections": [
            {
              "title": "section 3",
              "description": "section description 3"
            }
          ]
        },
        "forSaleDetails": {
          "price": 50,
          "itemCondition": "used"
        },

        "id": 1,
        "createdAt": "2023-12-30T15:01:32.219Z",
        "updatedAt": "2023-12-30T15:01:32.219Z",
        "category": "events",
        "title": "sample title 1",
        "location": "sample location 1",
        "description": "sample description 1",
        "eventDetails": {
          "eventType": "paid",
          "date": "2023-12-30",
          "time": "10:30",
          "tickets": [
            {
              "title": "ticket 1",
              "price": 10
            },
            {
              "title": "ticket 2",
              "price": 20
            }
          ]
        },
        "jobPostingDetails": {
          "sections": [
            {
              "title": "section 1",
              "description": "section description 1"
            },
            {
              "title": "section 2",
              "description": "section description 2"
            }
          ]
        },
        "forSaleDetails": {
          "price": 100,
          "itemCondition": "new"
        }
      },
      {
        "id": 3,
        "createdAt": "2023-12-30T15:02:45.123Z",
        "updatedAt": "2023-12-30T15:02:45.123Z",
        "category": "jobs",
        "title": "sample title 2",
        "location": "sample location 2",
        "description": "sample description 2",
        "eventDetails": {
          "eventType": "free",
          "date": "2023-12-31",
          "time": "14:00",
          "tickets": [
            {
              "title": "free ticket",
              "price": 0
            }
          ]
        },
        "jobPostingDetails": {
          "sections": [
            {
              "title": "section 3",
              "description": "section description 3"
            }
          ]
        },
        "forSaleDetails": {
          "price": 50,
          "itemCondition": "used"
        }


      },
      // Add more member data as needed
    ];

    // Convert dummy data to the list of Classified objects
    List<Classified> classifiedList = memberListData.map((data) =>
        Classified.fromJson(data)).toList();

    return classifiedList;
  }

}