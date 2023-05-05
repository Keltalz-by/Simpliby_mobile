import 'package:simplibuy/orders/data/models/accepted_orders.dart';

class IncomingOrder {
  final String image;
  final String name;
  final String itemId;
  final String time;

  IncomingOrder(this.image, this.name, this.itemId, this.time);
}

final orders = [
  IncomingOrder("", "Ikenwa John", "1783HAJE3", "10:30am"),
  IncomingOrder("", "Ikenwa John", "1783HAJE3", "10:30am"),
  IncomingOrder("", "Ikenwa John", "1783HAJE3", "10:30am")
];

final ordersA = [
  AcceptedOrder("", "Ikenwa John", "1783HAJE3", "Paid"),
  AcceptedOrder("", "Ikenwa John", "1783HAJE3", "Paid"),
  AcceptedOrder("", "Ikenwa John", "1783HAJE3", "Paid")
];
