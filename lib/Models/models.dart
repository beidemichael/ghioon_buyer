class UserAuth {
  final String uid;
  UserAuth({required this.uid});
}

class UserInformation {
  
  String userName;
  String phoneNumber;
  String userUid;
  String documentId;
  String email;
  String image;
  String gender;
  var birthday;
  UserInformation({
    required this.userName,
    required this.phoneNumber,
    required this.userUid,
    required this.documentId,
    required this.email,
    required this.image,
    required this.gender,
    required this.birthday
  });
}

class SellerInformation {
  String GhioonId;
  String userName;
  String phoneNumber;
  String userUid;
  bool approved;
  String documentId;
  String businessCategory;
  String businessName;
  String email;
  String businessNo;
  List collections;
  List collection_images;
  List collection_description;
  bool online;
  String address;
  int views;
  double rating;
  String image;
  List profileImages;
  String profileVideo;
  bool notification;
  SellerInformation({
    required this.GhioonId,
    required this.userName,
    required this.phoneNumber,
    required this.userUid,
    required this.approved,
    required this.documentId,
    required this.businessNo,
    required this.businessCategory,
    required this.businessName,
    required this.email,
    required this.collections,
    required this.collection_images,
    required this.collection_description,
    required this.online,
    required this.address,
    required this.views,
    required this.rating,
    required this.image,
    required this.profileImages,
    required this.profileVideo,
    required this.notification,
  });
}

class Categories {
  String type;
  String documentId;
  Categories({
    required this.type,
    required this.documentId,
  });
}

class LastId {
  int lastId;

  LastId({
    required this.lastId,
  });
}

class Product {
  String productId;
  String name;
  String description;
  bool fixed;
  List<dynamic> price;
  List<dynamic> rangeFrom;
  List<dynamic> rangeTo;
  String Product_Type;
  String Product_collection;
  double rating;
  String category;
  List image;
  bool inStock;
  int quantity;
  String documentId;
  String video;
  String barcode;

  Product({
    required this.productId,
    required this.name,
    required this.description,
    required this.fixed,
    required this.price,
    required this.rangeFrom,
    required this.rangeTo,
    required this.Product_Type,
    required this.Product_collection,
    required this.rating,
    required this.category,
    required this.image,
    required this.inStock,
    required this.quantity,
    required this.documentId,
    required this.video,
    required this.barcode,
  });
}

class ProductBar {
  String productId;
  String name;
  String description;
  bool fixed;
  List<dynamic> price;
  List<dynamic> rangeFrom;
  List<dynamic> rangeTo;
  String Product_Type;
  String Product_collection;
  double rating;
  String category;
  List image;
  bool inStock;
  int quantity;
  String documentId;
  String video;
  String barcode;

  ProductBar({
    required this.productId,
    required this.name,
    required this.description,
    required this.fixed,
    required this.price,
    required this.rangeFrom,
    required this.rangeTo,
    required this.Product_Type,
    required this.Product_collection,
    required this.rating,
    required this.category,
    required this.image,
    required this.inStock,
    required this.quantity,
    required this.documentId,
    required this.video,
    required this.barcode,
  });
}

class Collection {
  String collectionId;
  String name;
  String description;
  List image;
  String documentId;

  Collection({
    required this.collectionId,
    required this.name,
    required this.description,
    required this.image,
    required this.documentId,
  });
}

class CollectionItems {
  String productId;
  String name;
  String description;
  bool fixed;
  List<dynamic> price;
  List<dynamic> rangeFrom;
  List<dynamic> rangeTo;
  String Product_Type;
  String Product_collection;
  double rating;
  String category;
  List image;
  bool inStock;
  int quantity;
  String documentId;
  String video;
  CollectionItems({
    required this.productId,
    required this.name,
    required this.description,
    required this.fixed,
    required this.price,
    required this.rangeFrom,
    required this.rangeTo,
    required this.Product_Type,
    required this.Product_collection,
    required this.rating,
    required this.category,
    required this.image,
    required this.inStock,
    required this.quantity,
    required this.documentId,
    required this.video,
  });
}

class Review {
  String productId;
  List<String> reviews;
  Review({
    required this.productId,
    required this.reviews,
  });
}

class Controller {
  int sellerVersion;
  String documentId;
  Controller({
    required this.sellerVersion,
    required this.documentId,
  });
}

class Category {
  String type;
  String documentId;
  Category({required this.documentId, required this.type});
}
