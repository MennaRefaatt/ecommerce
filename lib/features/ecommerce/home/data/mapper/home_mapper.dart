import 'package:ecommerce/core/helpers/safe_print.dart';
import '../../domain/home_entity/home_entity.dart';
import '../models/home_model.dart';

class HomeMapper {
  static HomeEntity mapToEntity(HomeModel model) {
    safePrint("Fetched Products: ${model.data?.products}");
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
