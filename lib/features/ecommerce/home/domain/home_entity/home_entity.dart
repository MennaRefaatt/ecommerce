class HomeEntity {
  final bool status;
  final HomeDataEntity data;

  HomeEntity({required this.status, required this.data});
}

class HomeDataEntity {
  final List<ProductEntity> products;
  final List<BannerEntity> banners;

  HomeDataEntity({required this.products, required this.banners});
}

class BannerEntity {
  final int id;
  final String image;

  BannerEntity({required this.id, required this.image});
}

class ProductEntity {
  final String image;
  final String name;
  final int price;
  final bool isFav;
  final int oldPrice;
  final int discount;
  final int id;
  ProductEntity({
    required this.discount,
    required this.id,
    required this.image,
    required this.name,
    required this.price,
    required this.isFav,
    required this.oldPrice,
  });
}
