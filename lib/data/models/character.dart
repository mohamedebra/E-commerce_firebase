class Product {
  String? pid;
  int? pQuantity;
  String pName;
  String pPrice;
  String pDescription;
  String pCategory;
  String pLocation;

  Product({required this.pCategory,
    required this.pDescription,
    required this.pLocation,
    required this.pName,
    required this.pPrice,
     this.pid,
    this.pQuantity
  }
      );
}

class Order{
  int totalPrice;
  String address;
  String? id;
  Order({required this.address, required this.totalPrice,this.id});
}
