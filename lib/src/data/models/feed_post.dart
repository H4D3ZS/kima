import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kima/src/data/models/daily_status.dart';
import 'package:kima/src/utils/enums.dart';

part 'feed_post.g.dart';

@JsonSerializable(includeIfNull: false)
class FeedPost extends Equatable {
  final int id;
  final Post type;
  final DailyStatus? dailyStatus;

  const FeedPost({
    required this.id,
    required this.type,
    this.dailyStatus,
  });

  @override
  List<Object?> get props => [id, type, dailyStatus];

  FeedPost copyWith({
    int? id,
    Post? type,
    DailyStatus? dailyStatus,
  }) =>
      FeedPost(
        id: id ?? this.id,
        dailyStatus: dailyStatus ?? this.dailyStatus,
        type: type ?? this.type,
      );

  Map<String, dynamic> toJson() => _$FeedPostToJson(this);

  factory FeedPost.fromJson(Map<String, dynamic> json) => _$FeedPostFromJson(json);

  @override
  String toString() {
    return 'FeedPost{id: $id, type: $type, dailyStatus: $dailyStatus}';
  }
}
