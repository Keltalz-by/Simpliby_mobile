class StoreDetails {
  final bool success;
  final List<StoreData> data;

  StoreDetails({
    required this.success,
    required this.data,
  });

  factory StoreDetails.fromJson(Map<String, dynamic> json) {
    return StoreDetails(
      success: json['success'] as bool,
      data: (json['data'] as List)
          .map((storeData) => StoreData.fromJson(storeData))
          .toList(),
    );
  }
}

class StoreData {
  final int amountSold;
  final List<dynamic> numberOfTimesVisited;
  final String id;
  final String owner;
  final String businessName;
  final String businessLocation;
  final String description;
  final String address;
  final String city;
  final String country;
  final StoreImage storeImage;
  final StoreImage logo;
  final List<dynamic> followers;
  final List<String> followings;
  final bool isStoreVerified;
  final int balance;
  final int amountWithdrawn;
  final String plan;
  final int rating;
  final List<dynamic> buyersVisited;
  final String createdAt;
  final String updatedAt;
  final int v;

  factory StoreData.part(
      {required String id,
      required String businessName,
      required String logoUrl,
      required String address,
      required int rating,
      required String businessLocation}) {
    return StoreData(
      amountSold: 0,
      numberOfTimesVisited: [],
      id: id,
      owner: "",
      rating: rating,
      businessName: businessName,
      businessLocation: businessLocation,
      description: "",
      address: address,
      city: "",
      country: "",
      storeImage: StoreImage(url: "", publicId: ""),
      logo: StoreImage(url: logoUrl, publicId: ""),
      followers: [],
      followings: [],
      isStoreVerified: false,
      balance: 0,
      amountWithdrawn: 0,
      plan: "",
      buyersVisited: [],
      createdAt: "",
      updatedAt: "",
      v: 0,
    );
  }

  StoreData({
    required this.amountSold,
    required this.numberOfTimesVisited,
    required this.id,
    required this.owner,
    required this.businessName,
    required this.businessLocation,
    required this.description,
    required this.address,
    required this.rating,
    required this.city,
    required this.country,
    required this.storeImage,
    required this.logo,
    required this.followers,
    required this.followings,
    required this.isStoreVerified,
    required this.balance,
    required this.amountWithdrawn,
    required this.plan,
    required this.buyersVisited,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory StoreData.fromJson(Map<String, dynamic> json) {
    return StoreData(
      amountSold: json['amountSold'] as int,
      numberOfTimesVisited: json['numberOfTimesVisited'] as List<dynamic>,
      id: json['_id'] as String,
      owner: json['owner'] as String,
      businessName: json['businessName'] as String,
      businessLocation: json['businessLocation'] as String,
      rating: 1,
      description: json['description'] as String,
      address: json['address'] as String,
      city: json['city'] as String,
      country: json['country'] as String,
      storeImage: StoreImage.fromJson(json['storeImage']),
      logo: StoreImage.fromJson(json['logo']),
      followers: json['followers'] as List<dynamic>,
      followings: (json['followings'] as List<dynamic>)
          .map((following) => following as String)
          .toList(),
      isStoreVerified: json['isStoreVerified'] as bool,
      balance: json['balance'] as int,
      amountWithdrawn: json['amountWithdrawn'] as int,
      plan: json['plan'] as String,
      buyersVisited: json['buyersVisited'] as List<dynamic>,
      createdAt: json['createdAt'] as String,
      updatedAt: json['updatedAt'] as String,
      v: json['__v'] as int,
    );
  }
}

class StoreImage {
  final String url;
  final String publicId;

  StoreImage({
    required this.url,
    required this.publicId,
  });

  factory StoreImage.fromJson(Map<String, dynamic> json) {
    return StoreImage(
      url: json['url'] as String,
      publicId: json['publicId'] as String,
    );
  }
}
