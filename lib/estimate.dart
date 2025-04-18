import 'package:hive/hive.dart';

part 'estimate.g.dart';

@HiveType(typeId: 0)
class Estimate extends HiveObject {
  @HiveField(0)
  String supplier;

  @HiveField(1)
  String item;

  @HiveField(2)
  int price;

  @HiveField(3)
  String deliveryDate;

  Estimate({
    required this.supplier,
    required this.item,
    required this.price,
    required this.deliveryDate,
  });
}
