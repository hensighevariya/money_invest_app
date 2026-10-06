import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

base class CacheData extends Equatable {
  const CacheData({required this.data, required this.createAt});

  final String data;
  final DateTime createAt;

  factory CacheData.fromJson(Map<String, dynamic> json) {
    return CacheData(
      data: json['data'] as String,
      createAt: DateTime.fromMillisecondsSinceEpoch(
        (json['createdAt'] as int?) ?? 0,
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {'data': data, 'createdAt': createAt.millisecondsSinceEpoch};
  }

  @override
  List<Object?> get props => [data, createAt];
}

class CacheDataAdapter extends TypeAdapter<CacheData> {
  @override
  final int typeId = 200;

  @override
  CacheData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CacheData(
      data: fields[0] as String,
      createAt: fields[1] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, CacheData obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.data)
      ..writeByte(1)
      ..write(obj.createAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CacheDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
