class SellerProfileDetails {
  final List<String> storeImages;
  final String storeLogo;
  final String storeName;
  final String desc;
  final String email;
  final String number;
  final double followers;
  final String address;

  SellerProfileDetails(this.storeImages, this.storeLogo, this.storeName,
      this.desc, this.email, this.number, this.followers, this.address);

  SellerProfileDetails.demo(
      {this.storeImages = imges,
      this.storeLogo = "",
      this.storeName = "Roban Stores",
      this.desc =
          "This is currently the best store in the world. We provide you with the best you can ever imagine",
      this.email = "ebuka@gmail.com",
      this.followers = 232323,
      this.number = "0901348394",
      this.address = "32, Olorunsogo street, Ejigbo, Lagos"});
}

const List<String> imges = [];

class SellerSinglePromoPost {
  final String title;
  final String image;

  SellerSinglePromoPost(this.title, this.image);
}
