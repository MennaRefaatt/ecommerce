import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../../../core/di/di.dart';
import '../../../../maps/presentation/manager/location_cubit.dart';

class OrderRealtimeTracking extends StatefulWidget {
  const OrderRealtimeTracking({super.key, required this.addressLat, required this.addressLong});
final double addressLat;
final double addressLong;
  @override
  _OrderRealtimeTrackingState createState() => _OrderRealtimeTrackingState();
}

class _OrderRealtimeTrackingState extends State<OrderRealtimeTracking> {
  late GoogleMapController _mapController;
  late LocationCubit _locationCubit;
  Marker? driverMarker;
  Marker? clientMarker;
  Set<Polyline> _polylines = {};

  @override
  void initState() {
    super.initState();
    _locationCubit = LocationCubit(sl(), sl(),sl());
    _locationCubit.trackDriverLocation();
  }

  @override
  void dispose() {
    _locationCubit.close();
    _locationCubit.stopTrackingLocation();
    _mapController.dispose();
    super.dispose();
  }

  void _onMapCreated(GoogleMapController controller) {
    _mapController = controller;
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationCubit, LocationState>(
      bloc: _locationCubit,
      builder: (context, state) {
        if (state is LocationLoaded) {
          driverMarker = const Marker(
            markerId: MarkerId('driver'),
            position: LatLng(37.4219999, -120,),
            infoWindow: InfoWindow(title: "Driver"),
          );
          clientMarker = Marker(
            markerId: const MarkerId('client'),
            position: LatLng(widget.addressLat, widget.addressLong),
            infoWindow: const InfoWindow(title: "Client"),
          );

          _updatePolylines();

          return SizedBox(
              height: 200.h,
              child: GoogleMap(
                onMapCreated: _onMapCreated,
                markers: {if (driverMarker != null) driverMarker!, if (clientMarker != null) clientMarker!},
                polylines: _polylines,
                initialCameraPosition: CameraPosition(
                  target: LatLng(state.position.latitude, state.position.longitude),
                  zoom: 15,
                ),
              ),
          );
        }
        return const Center(child: CircularProgressIndicator());
      },
    );
  }

  void _updatePolylines() {
    _polylines = {Polyline(
      polylineId: const PolylineId('route'),
      visible: true,
      points: [driverMarker!.position, clientMarker!.position],
      width: 5,
      color: Colors.black,
    )};
  }
}