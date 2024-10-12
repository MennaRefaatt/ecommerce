import 'package:ecommerce/features/home/data/models/home_model.dart';

import '../../domain/hom_entity/home_entity.dart';

class HomeMapper {
  static HomeEntity mapToEntity(HomeModel model) {
    return HomeEntity(
      status: model.status ?? false,
      data: model.data != null
          ? mapToHomeDataEntity(model.data!)
          : HomeDataEntity(products: [], banners: []),
    );
  }

  static HomeDataEntity mapToHomeDataEntity(HomeData data) {
    return HomeDataEntity(
      products:
          data.products.map((product) => mapToProductEntity(product)).toList(),
      banners: data.banners.map((banner) => mapToBannerEntity(banner)).toList(),
    );
  }

  static BannerEntity mapToBannerEntity(HomeBanners banner) {
    return BannerEntity(
      image: banner.image ?? '',
      id: banner.id ?? 0,
    );
  }

  static ProductEntity mapToProductEntity(HomeProducts product) {
    return ProductEntity(
      discount: product.discount ?? 0.0,
      id: product.id ?? 0,
      image: product.image ?? '',
      name: product.name ?? '',
      price: product.price?.toDouble() ?? 0.0,
      isFav: product.isFav ?? false,
      oldPrice: product.oldPrice ?? 0.0,
    );
  }
}
