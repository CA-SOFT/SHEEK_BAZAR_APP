import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:latlong2/latlong.dart';
import 'package:sheek_bazar/core/utils/app_colors.dart';
import 'package:sheek_bazar/core/utils/app_constants.dart';
import 'package:sheek_bazar/features/user/shops/presentation/cubit/shops_cubit.dart';
import 'package:sheek_bazar/features/user/shops/presentation/widgets/item_for_info_widget.dart';

class ShopInformationWidget extends StatelessWidget {
  const ShopInformationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<ShopsCubit, ShopsState>(
        builder: (context, state) {
          return Column(
            children: [
              state.products!.supplierInfo![0].supplierPhone == null
                  ? const SizedBox()
                  : ItemForInfo(
                      description:
                          "${state.products!.supplierInfo![0].supplierPhone}",
                      title: "phone_number",
                      icon: const Icon(
                        Icons.phone,
                      ),
                    ),
              state.products!.supplierInfo![0].supplierEmail == null
                  ? const SizedBox()
                  : ItemForInfo(
                      description:
                          "${state.products!.supplierInfo![0].supplierEmail}",
                      title: "email",
                      icon: const Icon(
                        Icons.email,
                      ),
                    ),
              state.products!.supplierInfo![0].latitude == null &&
                      state.products!.supplierInfo![0].longtitude == null
                  ? const SizedBox()
                  : SizedBox(
                      height: 0.4.sh,
                      width: 0.9.sw,
                      child: FlutterMap(
                        options: MapOptions(
                          initialZoom: 15,
                          initialCenter: LatLng(
                              double.parse(
                                  state.products!.supplierInfo![0].latitude!),
                              double.parse(state
                                  .products!.supplierInfo![0].longtitude!)),
                        ),
                        children: [
                          TileLayer(
                            urlTemplate:
                                'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                            userAgentPackageName:
                                'dev.fleaflet.flutter_map.example',
                          ),
                          MarkerLayer(
                            markers: [
                              Marker(
                                width: 30.0,
                                height: 30.0,
                                point: LatLng(
                                    double.parse(state
                                        .products!.supplierInfo![0].latitude!),
                                    double.parse(state.products!
                                        .supplierInfo![0].longtitude!)),
                                child: Icon(Icons.location_on,
                                    size: 75.w, color: AppColors.primaryColor),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
              AppConstant.customSizedBox(0, 50)
            ],
          );
        },
      ),
    );
  }
}
