import 'package:flutter/foundation.dart';

class Food {
  final int Id;
  final String Name;
  final String PicPath;
  final double Fee;
  final String Description;

//<editor-fold desc="Data Methods" defaultstate="collapsed">

  const Food({
    @required this.Id,
    @required this.Name,
    @required this.PicPath,
    @required this.Fee,
    @required this.Description,
  });

  Food copyWith({
    int Id,
    String Name,
    String PicPath,
    double Fee,
    String Description,
  }) {
    if ((Id == null || identical(Id, this.Id)) &&
        (Name == null || identical(Name, this.Name)) &&
        (PicPath == null || identical(PicPath, this.PicPath)) &&
        (Fee == null || identical(Fee, this.Fee)) &&
        (Description == null || identical(Description, this.Description))) {
      return this;
    }

    return new Food(
      Id: Id ?? this.Id,
      Name: Name ?? this.Name,
      PicPath: PicPath ?? this.PicPath,
      Fee: Fee ?? this.Fee,
      Description: Description ?? this.Description,
    );
  }

  @override
  String toString() {
    return 'Food{Id: $Id, Name: $Name, PicPath: $PicPath, Fee: $Fee, Description: $Description}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Food &&
          runtimeType == other.runtimeType &&
          Id == other.Id &&
          Name == other.Name &&
          PicPath == other.PicPath &&
          Fee == other.Fee &&
          Description == other.Description);

  @override
  int get hashCode =>
      Id.hashCode ^
      Name.hashCode ^
      PicPath.hashCode ^
      Fee.hashCode ^
      Description.hashCode;

  factory Food.fromMap(
    Map<String, dynamic> map, {
    String keyMapper(String key),
  }) {
    keyMapper ??= (key) => key;

    return new Food(
      Id: map[keyMapper('Id')] as int,
      Name: map[keyMapper('Name')] as String,
      PicPath: map[keyMapper('PicPath')] as String,
      Fee: map[keyMapper('Fee')] as double,
      Description: map[keyMapper('Description')] as String,
    );
  }

  Map<String, dynamic> toMap({
    String keyMapper(String key),
  }) {
    keyMapper ??= (key) => key;

// ignore: unnecessary_cast
    return {
      keyMapper('Id'): this.Id,
      keyMapper('Name'): this.Name,
      keyMapper('PicPath'): this.PicPath,
      keyMapper('Fee'): this.Fee,
      keyMapper('Description'): this.Description,
    } as Map<String, dynamic>;
  }

//</editor-fold>

}
