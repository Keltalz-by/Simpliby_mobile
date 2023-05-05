class AcceptedOrderDetail {
  final String image;
  final String name;
  final String ticketId;
  final String status;
  final String number;
  final String amount;
  final String pickupTime;
  final List<ItemNameAndPrice> items;

  AcceptedOrderDetail(this.image, this.name, this.ticketId, this.status,
      this.number, this.amount, this.pickupTime, this.items);

  AcceptedOrderDetail.empty(
      {this.image = "",
      this.name = "",
      this.amount = "",
      this.ticketId = "",
      this.status = "",
      this.number = "",
      this.pickupTime = "",
      this.items = emp});
}

const List<ItemNameAndPrice> emp = [];

class ItemNameAndPrice {
  final String name;
  final String price;

  ItemNameAndPrice(this.name, this.price);
}
