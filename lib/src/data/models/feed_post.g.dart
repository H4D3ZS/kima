// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FeedPost _$FeedPostFromJson(Map<String, dynamic> json) => FeedPost(
      id: json['id'] as int,
      type: $enumDecode(_$PostEnumMap, json['type']),
      dailyStatus: json['dailyStatus'] == null
          ? null
          : DailyStatus.fromJson(json['dailyStatus'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$FeedPostToJson(FeedPost instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'type': _$PostEnumMap[instance.type]!,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('dailyStatus', instance.dailyStatus);
  return val;
}

const _$PostEnumMap = {
  Post.classifieds: 'classifieds',
  Post.status: 'status',
};
