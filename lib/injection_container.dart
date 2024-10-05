import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sheek_bazar/features/auth/data/datasources/forget_password_ds.dart';
import 'package:sheek_bazar/features/auth/data/datasources/login_ds.dart';
import 'package:sheek_bazar/features/auth/data/datasources/signUp_ds.dart';
import 'package:sheek_bazar/features/auth/data/repositories/forget_password_repo.dart';
import 'package:sheek_bazar/features/auth/data/repositories/login_repo.dart';
import 'package:sheek_bazar/features/auth/data/repositories/signUp_repo.dart';
import 'package:sheek_bazar/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:sheek_bazar/features/suppliers/add_product/data/datasources/add_product_ds.dart';
import 'package:sheek_bazar/features/suppliers/add_product/data/repositories/add_product_repo.dart';
import 'package:sheek_bazar/features/suppliers/add_product/presentation/cubit/add_product_cubit.dart';
import 'package:sheek_bazar/features/suppliers/profile/data/datasources/delete_product_ds.dart';
import 'package:sheek_bazar/features/suppliers/profile/data/datasources/update_product_ds.dart';
import 'package:sheek_bazar/features/suppliers/profile/data/repositories/delete_product_repo.dart';
import 'package:sheek_bazar/features/suppliers/profile/data/repositories/update_product_repo.dart';
import 'package:sheek_bazar/features/suppliers/profile/presentation/cubit/profile_cubit.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/data/datasources/confirm_order_model.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/data/datasources/get_order_details_ds.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/data/datasources/get_orders_ds.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/data/repositories/confirm_order_repo.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/data/repositories/get_order_details_repo.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/data/repositories/get_orders_repo.dart';
import 'package:sheek_bazar/features/suppliers/supplier_order/presentation/bloc/supplier_order_bloc.dart';
import 'package:sheek_bazar/features/user/cart/data/datasources/address_ds.dart';
import 'package:sheek_bazar/features/user/cart/data/datasources/cart_ds.dart';
import 'package:sheek_bazar/features/user/cart/data/datasources/checkout_ds.dart';
import 'package:sheek_bazar/features/user/cart/data/repositories/cart_repo.dart';
import 'package:sheek_bazar/features/user/cart/data/repositories/checkout_repo.dart';
import 'package:sheek_bazar/features/user/cart/data/repositories/myAddress_repo.dart';
import 'package:sheek_bazar/features/user/cart/presentation/cubit/cart_cubit.dart';
import 'package:sheek_bazar/features/user/categories/data/datasources/categories_ds.dart';
import 'package:sheek_bazar/features/user/categories/data/repositories/categories_repo.dart';
import 'package:sheek_bazar/features/user/categories/presentation/cubit/categories_cubit.dart';
import 'package:sheek_bazar/features/user/home/data/datasources/home_ds.dart';
import 'package:sheek_bazar/features/user/home/data/datasources/productDetails_ds.dart';
import 'package:sheek_bazar/features/user/home/data/datasources/use_app_ds.dart';
import 'package:sheek_bazar/features/user/home/data/repositories/home_repo.dart';
import 'package:sheek_bazar/features/user/home/data/repositories/productDetails_repo.dart';
import 'package:sheek_bazar/features/user/home/data/repositories/use_app_repo.dart';
import 'package:sheek_bazar/features/user/home/presentation/cubit/home_cubit.dart';
import 'package:sheek_bazar/features/user/laundry/data/datasources/laundry_ds.dart';
import 'package:sheek_bazar/features/user/laundry/data/repositories/laundry_repo.dart';
import 'package:sheek_bazar/features/user/laundry/presentation/cubit/laundry_cubit.dart';
import 'package:sheek_bazar/features/user/profile/data/datasources/collect_points_ds.dart';
import 'package:sheek_bazar/features/user/profile/data/datasources/favorite_ds.dart';
import 'package:sheek_bazar/features/user/profile/data/datasources/get_user_info_ds.dart';
import 'package:sheek_bazar/features/user/profile/data/datasources/orderDetails_ds.dart';
import 'package:sheek_bazar/features/user/profile/data/datasources/orders_ds.dart';
import 'package:sheek_bazar/features/user/profile/data/datasources/pay_by_points_ds.dart';
import 'package:sheek_bazar/features/user/profile/data/datasources/point_ds.dart';
import 'package:sheek_bazar/features/user/profile/data/datasources/updateProfile_ds.dart';
import 'package:sheek_bazar/features/user/profile/data/repositories/collect_points_repo.dart';
import 'package:sheek_bazar/features/user/profile/data/repositories/favorite_repo.dart';
import 'package:sheek_bazar/features/user/profile/data/repositories/get_user_info_repo.dart';
import 'package:sheek_bazar/features/user/profile/data/repositories/orderDetails_repo.dart';
import 'package:sheek_bazar/features/user/profile/data/repositories/orders_repo.dart';
import 'package:sheek_bazar/features/user/profile/data/repositories/pay_by_points_repo.dart';
import 'package:sheek_bazar/features/user/profile/data/repositories/points_repo.dart';
import 'package:sheek_bazar/features/user/profile/data/repositories/updateProfile_repo.dart';
import 'package:sheek_bazar/features/user/profile/presentation/cubit/profile_cubit.dart';
import 'package:sheek_bazar/features/user/shops/data/datasources/follow_ds.dart';
import 'package:sheek_bazar/features/user/shops/data/datasources/followers_ds.dart';
import 'package:sheek_bazar/features/user/shops/data/datasources/getProducts_ds.dart';
import 'package:sheek_bazar/features/user/shops/data/datasources/shops_ds.dart';
import 'package:sheek_bazar/features/user/shops/data/repositories/follow_repo.dart';
import 'package:sheek_bazar/features/user/shops/data/repositories/followers_repo.dart';
import 'package:sheek_bazar/features/user/shops/data/repositories/getProducts_repo.dart';
import 'package:sheek_bazar/features/user/shops/data/repositories/shops_repo.dart';
import 'package:sheek_bazar/features/user/shops/presentation/cubit/shops_cubit.dart';

import 'Locale/cubit/locale_cubit.dart';
import 'core/utils/http_helper.dart';

final sl = GetIt.instance;
Future<void> init() async {
  sl.registerLazySingleton(() => ApiBaseHelper("https://sheek-bazar.com/app"));

  //cubit
  sl.registerFactory(() => HomeCubit(homeRepo: sl(), useAppRepo: sl()));
  sl.registerFactory(() =>
      AuthCubit(logInRepo: sl(), signUpRepo: sl(), forgetPassswordRepo: sl()));
  sl.registerFactory(
      () => CartCubit(myAddressRepo: sl(), cartRepo: sl(), checkoutRepo: sl()));
  sl.registerFactory(() => ProductDetailsCubit(productDetailsRepo: sl()));
  sl.registerFactory(() => LocaleCubit());
  // sl.registerFactory(() => InternetCubit());
  sl.registerFactory(() => ProfileCubit(
      favoriteRepo: sl(),
      payByPointsRepo: sl(),
      pointsRepo: sl(),
      collectPointsRepo: sl(),
      getUserInfoRepo: sl(),
      updateProfileRepo: sl(),
      ordersRepo: sl(),
      orderDetailsRepo: sl()));
  sl.registerFactory(() => ShopsCubit(
      shopsRepo: sl(),
      getProductsRepo: sl(),
      followRepo: sl(),
      followersRepo: sl()));
  sl.registerFactory(() => CategoriesCubit(categoriesRepo: sl()));
  sl.registerFactory(() => LaundryCubit(lundryRepo: sl()));
  sl.registerFactory(() => AddProductCubit(addProductRepo: sl()));
  sl.registerFactory(() =>
      SupplierProfileCubit(updateProductRepo: sl(), deleteProductRepo: sl()));
  sl.registerFactory(() => SupplierOrderCubit(
      getSupplierOrders: sl(),
      getSupplierOrderDetailsRepo: sl(),
      confirmRepo: sl()));
  //Repo
  sl.registerLazySingleton(() => HomeRepo(dataSource: sl()));
  sl.registerLazySingleton(() => LogInRepo(dataSource: sl()));
  sl.registerLazySingleton(() => SignUpRepo(dataSource: sl()));
  sl.registerLazySingleton(() => MyAddressRepo(dataSource: sl()));
  sl.registerLazySingleton(() => CartRepo(dataSource: sl()));
  sl.registerLazySingleton(() => FavoriteRepo(dataSource: sl()));
  sl.registerLazySingleton(() => ProductDetailsRepo(dataSource: sl()));
  sl.registerLazySingleton(() => ShopsRepo(dataSource: sl()));
  sl.registerLazySingleton(() => CategoriesRepo(dataSource: sl()));
  sl.registerLazySingleton(() => UpdateProfileRepo(dataSource: sl()));
  sl.registerLazySingleton(() => CheckoutRepo(dataSource: sl()));
  sl.registerLazySingleton(() => GetProductsRepo(dataSource: sl()));
  sl.registerLazySingleton(() => LundryRepo(dataSource: sl()));
  sl.registerLazySingleton(() => OrdersRepo(dataSource: sl()));
  sl.registerLazySingleton(() => OrderDetailsRepo(dataSource: sl()));
  sl.registerLazySingleton(() => ForgetPassswordRepo(dataSource: sl()));
  sl.registerLazySingleton(() => AddProductRepo(dataSource: sl()));
  sl.registerLazySingleton(() => GetSupplierOrdersRepo(dataSource: sl()));
  sl.registerLazySingleton(() => GetSupplierOrderDetailsRepo(dataSource: sl()));
  sl.registerLazySingleton(() => ConfirmRepo(dataSource: sl()));
  sl.registerLazySingleton(() => PointsRepo(dataSource: sl()));
  sl.registerLazySingleton(() => UseAppRepo(dataSource: sl()));
  sl.registerLazySingleton(() => CollectPointsRepo(dataSource: sl()));
  sl.registerLazySingleton(() => FollowRepo(dataSource: sl()));
  sl.registerLazySingleton(() => GetUserInfoRepo(dataSource: sl()));
  sl.registerLazySingleton(() => PayByPointsRepo(dataSource: sl()));
  sl.registerLazySingleton(() => UpdateProductRepo(dataSource: sl()));
  sl.registerLazySingleton(() => DeleteProductRepo(dataSource: sl()));
  sl.registerLazySingleton(() => FollowersRepo(dataSource: sl()));
  //DataSources
  sl.registerLazySingleton(() => HomeDs(apiHelper: sl()));
  sl.registerLazySingleton(() => LogInDs(apiHelper: sl()));
  sl.registerLazySingleton(() => SignUpDs(apiHelper: sl()));
  sl.registerLazySingleton(() => AddressDs(apiHelper: sl()));
  sl.registerLazySingleton(() => CartDs(apiHelper: sl()));
  sl.registerLazySingleton(() => FavoriteDS(apiHelper: sl()));
  sl.registerLazySingleton(() => ProductDetailsDs(apiHelper: sl()));
  sl.registerLazySingleton(() => ShopsDs(apiHelper: sl()));
  sl.registerLazySingleton(() => CategoriesDS(apiHelper: sl()));
  sl.registerLazySingleton(() => UpdateProfileDS(apiHelper: sl()));
  sl.registerLazySingleton(() => CheckOutDS(apiHelper: sl()));
  sl.registerLazySingleton(() => GetProductsDS(apiHelper: sl()));
  sl.registerLazySingleton(() => LaundryDS(apiHelper: sl()));
  sl.registerLazySingleton(() => OrdersDS(apiHelper: sl()));
  sl.registerLazySingleton(() => OrderDetailsDS(apiHelper: sl()));
  sl.registerLazySingleton(() => ForgetPAsswordDS(apiHelper: sl()));
  sl.registerLazySingleton(() => AddProductDS(apiHelper: sl()));
  sl.registerLazySingleton(() => SupllierOrdersDS(apiHelper: sl()));
  sl.registerLazySingleton(() => SupllierOrderDeatilsDS(apiHelper: sl()));
  sl.registerLazySingleton(() => ConfirmOrderDs(apiHelper: sl()));
  sl.registerLazySingleton(() => PointsDS(apiHelper: sl()));
  sl.registerLazySingleton(() => UseAppDS(apiHelper: sl()));
  sl.registerLazySingleton(() => CollectPointsDS(apiHelper: sl()));
  sl.registerLazySingleton(() => FollowDs(apiHelper: sl()));
  sl.registerLazySingleton(() => GetUserInfoDS(apiHelper: sl()));
  sl.registerLazySingleton(() => PayByPointsDS(apiHelper: sl()));
  sl.registerLazySingleton(() => UpdateProductDS(apiHelper: sl()));
  sl.registerLazySingleton(() => DeleteProductDS(apiHelper: sl()));
  sl.registerLazySingleton(() => GetFollowersDS(apiHelper: sl()));

  /////External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
}
