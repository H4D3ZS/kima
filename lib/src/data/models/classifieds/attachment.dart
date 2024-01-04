import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'attachment.g.dart';

@JsonSerializable(includeIfNull: false)
class Attachment extends Equatable {
  final int? id;
  final String? imageUrl;

  const Attachment({
    this.id,
    this.imageUrl,
  });

  @override
  List<Object?> get props => [id, imageUrl];

  Attachment copyWith({
    int? id,
    String? imageUrl,
  }) =>
      Attachment(
        id: id ?? this.id,
        imageUrl: imageUrl ?? this.imageUrl,
      );

  Map<String, dynamic> toJson() => _$AttachmentToJson(this);

  factory Attachment.fromJson(Map<String, dynamic> json) => _$AttachmentFromJson(json);

  @override
  String toString() {
    return 'Attachment{id: $id, imageUrl: $imageUrl}';
  }
}
