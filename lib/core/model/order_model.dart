class OrderModel {
  final String name;
  final String address;
  final String mobile;
  final String productName;
  final String image;
  final String price;
  final int Quantity;

  OrderModel(
      {required this.name,
      required this.address,
      required this.mobile,
      required this.productName,
      required this.image,
      required this.price,
      required this.Quantity});

  factory OrderModel.jsonData(jsonData) {
    return OrderModel(
        name: jsonData['name'],
        address: jsonData['address'],
        mobile: jsonData['MobileNumber'],
        productName: jsonData['ProductName'],
        image: jsonData['imageOfProuct'],
        price: jsonData['Price'],
        Quantity: jsonData['Quanitiy']);
  }
}
