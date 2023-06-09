import 'package:ghioon_buyer/Screens/HomeScreenWidets/1,Cart.dart';

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
  UserInformation(
      {required this.userName,
      required this.phoneNumber,
      required this.userUid,
      required this.documentId,
      required this.email,
      required this.image,
      required this.gender,
      required this.birthday});
}

class SellerInformation {
  String GhioonId;
  String userName;
  String phoneNumber;
  String userUid;
  bool approved;
  String documentId;
  List businessCategory;
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
  List viewCountTime;
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
    required this.viewCountTime,
  });
}

class Categories {
 String type;
  String documentId;
  String name;
  String image;
  Categories({
     required this.type,
    required this.documentId,
    required this.name,
    required this.image

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
  String userUid;
  String barcode;
  var created;
  List viewCountTime;

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
    required this.userUid,
    required this.barcode,
    required this.created,
    required this.viewCountTime,
  });

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      productId: map['productId'],
      name: map['name'],
      description: map['description'],
      fixed: map['fixed'],
      price: map['price'],
      rangeFrom: map['rangeFrom'],
      rangeTo: map['rangeTo'],
      Product_Type: map['Product_Type'],
      Product_collection: map['Product_collection'],
      rating: map['rating'],
      video: map['video'],
      category: map['category'],
      image: map['image'],
      inStock: map['isStock'],
      quantity: map['quantity'],
      barcode: '', // map['barcode'],
      userUid: map['userUid'],
      documentId: map['productId'],
      created: map['created'],
      viewCountTime: map['viewCountTime']
    );
  }
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
  String name;
  String image;
  Category({
    required this.documentId,
    required this.type,
    required this.image,
    required this.name,
  });
}

class CartItems {
  Product product;
  int quantity;
  String sellerId;
  CartItems(
      {required this.product, required this.quantity, required this.sellerId});
}

class CompanyPromo {
  String image;
  String id;
  CompanyPromo({required this.image, required this.id});
}

class Addresses {
  String userUid;
  double longitude;
  double latitude;
  String information;
  String name;
  String documentId;
  Addresses(
      {required this.information,
      required this.latitude,
      required this.longitude,
      required this.userUid,
      required this.name,
      required this.documentId});
}

class Orders {
  List foodName;
  List foodPrice;
  List foodQuantity;
  List foodImage;
  double subTotal;

  bool isTaken;
  bool isDelivered;
  bool isCancelled;
  String userName;
  String userPhone;
  String userUid;
  String userPic;
  double longitude;
  double latitude;
  String information;
  var created;
  String orderNumber;
  String loungeOrderNumber;
  double serviceCharge;
  double deliveryFee;
  double tip;
  double distance;

  String documentId;
  double carrierLatitude;
  double carrierLongitude;
  String carrierName;
  String carrierImage;
  String carrierPhone;
  bool isBeingPrepared;

  Orders({
    required this.created,
    required this.deliveryFee,
    required this.distance,
    required this.foodImage,
    required this.foodName,
    required this.foodPrice,
    required this.foodQuantity,
    required this.information,
    required this.isCancelled,
    required this.isDelivered,
    required this.isTaken,
    required this.latitude,
    required this.longitude,
    required this.loungeOrderNumber,
    required this.orderNumber,
    required this.serviceCharge,
    required this.subTotal,
    required this.tip,
    required this.userName,
    required this.userPhone,
    required this.userPic,
    required this.userUid,
    required this.documentId,
    required this.carrierLatitude,
    required this.carrierLongitude,
    required this.carrierPhone,
    required this.isBeingPrepared,
    required this.carrierImage,
    required this.carrierName,
  });
}

class Promotion {
  String image;
  String video;
  bool isImage;
  String sellerUid;
  String screenRealestate;
  Promotion({
    required this.image,
    required this.video,
    required this.isImage,
    required this.sellerUid,
    required this.screenRealestate,
  });
}

class VersionController {
  int sellerVersion;
  String documentId;
  VersionController({
    required this.sellerVersion,
    required this.documentId,
  });
}
