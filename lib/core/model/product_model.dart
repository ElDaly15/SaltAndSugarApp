class ProductModel {
  final String productName;
  final String price;
  final String image;

  ProductModel(
      {required this.productName, required this.price, required this.image});

  factory ProductModel.formJson(jsonData) {
    return ProductModel(
        productName: jsonData['productName'],
        price: jsonData['price'],
        image: jsonData['Image']);
  }
}
