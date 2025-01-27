import 'package:ecommerce/core/helpers/safe_print.dart';
import 'package:ecommerce/core/theming/app_colors.dart';
import 'package:ecommerce/core/utils/app_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../core/helpers/shared_pref.dart';
import '../../../../../core/helpers/shared_pref_keys.dart';
import '../../../../../core/services/navigation/app_endpoints.dart';
import '../manager/location_cubit.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late GoogleMapController _mapController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<LocationCubit, LocationState>(
        builder: (context, state) {
          if (state is LocationLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is LocationLoaded || state is LocationMarkerSet) {
            final position = state is LocationLoaded
                ? LatLng(state.position.latitude, state.position.longitude)
                : (state as LocationMarkerSet).location;
            final address = state is LocationLoaded
                ? state.address
                : (state as LocationMarkerSet).address;

            return Column(
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      GoogleMap(
                        initialCameraPosition: CameraPosition(
                          target: position,
                          zoom: 14,
                        ),
                        onMapCreated: (controller) {
                          _mapController = controller;
                        },
                        markers: {
                          Marker(
                            markerId: const MarkerId('selectedLocation'),
                            position: position,
                            icon: BitmapDescriptor.defaultMarkerWithHue(
                              BitmapDescriptor.hueRed,
                            ),
                          ),
                        },
                        onTap: (LatLng tappedLocation) {
                          context
                              .read<LocationCubit>()
                              .setMarker(tappedLocation);
                        },
                      ),
                      state is LocationMarkerSet
                          ? AppButton(
                              text: "Save Location",
                              backgroundColor: AppColors.primary,
                              onPressed: () async {
                                final selectedLocation = context
                                    .read<LocationCubit>()
                                    .selectedLocation;
                                if (selectedLocation != null) {
                                  safePrint("Saved Location: $address");
                                  SharedPref.setString(
                                      key: MySharedKeys.city, value: address);
                                  SharedPref.putInt(
                                      key: MySharedKeys.defaultAddressId,
                                      value: selectedLocation.latitude.toInt() +
                                          selectedLocation.longitude.toInt());
                                  Navigator.pushNamed(
                                      context, AppEndpoints.confirmOrderScreen);
                                }
                              },
                              textStyle: const TextStyle(color: Colors.white),
                            )
                          : Container(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    state is LocationMarkerSet
                        ? "Address: ${state.location}"
                        : "Tap on the map to select a location",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            );
          } else if (state is LocationError) {
            return Center(child: Text(state.message));
          }
          return const Center(child: Text("Press the button to get location"));
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.primary,
        onPressed: () => context.read<LocationCubit>().fetchUserLocation(),
        child: const Icon(CupertinoIcons.location_solid),
      ),
    );
  }
}
