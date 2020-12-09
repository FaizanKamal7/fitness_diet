import 'dart:async';
import 'dart:typed_data';
import 'package:checkbox_grouped/checkbox_grouped.dart';
import 'package:fitness_diet/core/enums/viewstate.dart';
import 'package:fitness_diet/core/models/orders.dart';
import 'package:fitness_diet/core/viewmodels/delivViewModel.dart';
import 'package:fitness_diet/ui/shared/loading.dart';
import 'package:fitness_diet/ui/views/baseView.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardHeadingNoBg.dart';
import 'package:fitness_diet/ui/widgets/Texts/standardLinkText.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

// ignore: must_be_immutable
class UpdateOrderStatusView extends StatefulWidget {
  Order passedOrder;
  UpdateOrderStatusView({@required this.passedOrder});
  @override
  _UpdateOrderStatusViewState createState() => _UpdateOrderStatusViewState();
}

class _UpdateOrderStatusViewState extends State<UpdateOrderStatusView> {
  // >>>>>> orderStatusInfo Below
  GlobalKey<SimpleGroupedChipsState<int>> chipKey =
      GlobalKey<SimpleGroupedChipsState<int>>();
  List _updatedStatusList;
  List<int> _statusListValues = [1, 2, 3, 4, 5, 6];
  List<String> _statusListText = [
    "Order Placed   ",
    "Order Processed   ",
    "Order Dispatched   ",
    "Order Completed   ",
    "Order Cancelled   ",
    "Order Failed   ",
  ];

  // >>>>>> Location Info
  StreamSubscription _locationSubscription;
  Location _locationTracker = Location();
  Marker marker;
  Circle circle;
  GoogleMapController _controller;

  // this set will hold my markers
  Set<Marker> _markers = {};
  // this will hold the generated polylines
  Set<Polyline> _polylines = {};
  // this will hold each polyline coordinate as Lat and Lng pairs
  List<LatLng> polylineCoordinates = [];
  // this is the key object - the PolylinePoints
  // which generates every polyline between start and finish
    // PolylinePoints polylinePoints = PolylinePoints();
  // for my custom icons
  BitmapDescriptor sourceIcon;
  BitmapDescriptor destinationIcon;

  static final CameraPosition initialLocation = CameraPosition(
    target: LatLng(34.195317, 73.235871),
    zoom: 10,
  );
  static final CameraPosition targetLocation = CameraPosition(
    target: LatLng(34.218878, 73.244566),
    zoom: 10,
  );

  double CAMERA_ZOOM = 13;
  double CAMERA_TILT = 0;
  double CAMERA_BEARING = 30;
  LatLng SOURCE_LOCATION = LatLng(42.7477863, -71.1699932);
  LatLng DEST_LOCATION = LatLng(42.6871386, -71.2143403);

// ------------------------------------------------------------------------------
  Future<Uint8List> getMarker() async {
    ByteData byteData =
        await DefaultAssetBundle.of(context).load("assets/images/car_icon.png");
    return byteData.buffer.asUint8List();
  }

  void updateMarkerAndCircle(LocationData newLocalData, Uint8List imageData) {
    LatLng latlng = LatLng(newLocalData.latitude, newLocalData.longitude);
    this.setState(() {
      marker = Marker(
          markerId: MarkerId("home"),
          position: latlng,
          rotation: newLocalData.heading,
          draggable: false,
          zIndex: 2,
          flat: true,
          anchor: Offset(0.5, 0.5),
          icon: BitmapDescriptor.fromBytes(imageData));
      circle = Circle(
          circleId: CircleId("car"),
          radius: newLocalData.accuracy,
          zIndex: 1,
          strokeColor: Colors.blue,
          center: latlng,
          fillColor: Colors.blue.withAlpha(70));
    });
  }

  void getCurrentLocation() async {
    try {
      Uint8List imageData = await getMarker();
      var location = await _locationTracker.getLocation();

      updateMarkerAndCircle(location, imageData);

      if (_locationSubscription != null) {
        _locationSubscription.cancel();
      }

      _locationSubscription =
          _locationTracker.onLocationChanged.listen((newLocalData) {
        if (_controller != null) {
          _controller.animateCamera(
            CameraUpdate.newCameraPosition(
              new CameraPosition(
                bearing: 192.8334901395799,
                target: LatLng(newLocalData.latitude, newLocalData.longitude),
                tilt: 0,
                zoom: 18.00,
              ),
            ),
          );
          updateMarkerAndCircle(newLocalData, imageData);
        }
      });
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        debugPrint("Permission Denied");
      }
    }
  }
//  setPolylines() async {

//         List<PointLatLng> result = await polylinePoints?.getRouteBetweenCoordinates(
//             googleAPIKey,
//             SOURCE_LOCATION.latitude,
//             SOURCE_LOCATION.longitude,
//             DEST_LOCATION.latitude,
//             DEST_LOCATION.longitude);
//         if (result.isNotEmpty) {
//           // loop through all PointLatLng points and convert them
//           // to a list of LatLng, required by the Polyline
//           result.forEach((PointLatLng point) {
//             polylineCoordinates.add(LatLng(point.latitude, point.longitude));
//           });
//         }

//       setState(() {
//           // create a Polyline instance
//           // with an id, an RGB color and the list of LatLng pairs
//           Polyline polyline = Polyline(
//               polylineId: PolylineId("poly"),
//               color: Color.fromARGB(255, 40, 122, 198),
//               points: polylineCoordinates);

//           // add the constructed polyline as a set of points
//           // to the polyline set, which will eventually
//           // end up showing up on the map
//           _polylines.add(polyline);
//       });
//   }
  @override
  void dispose() {
    if (_locationSubscription != null) {
      _locationSubscription.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    return BaseView<DelivViewModel>(
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(title: Text("Order ID: " + widget.passedOrder.orderID)),
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          getCurrentLocation();
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: Container(
                            margin: EdgeInsets.all(10),
                            height: deviceSize.height * 0.04,
                            width: deviceSize.height * 0.04,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child:
                                Center(child: Icon(Icons.location_searching)),
                          ),
                        ),
                      ),
                      GoogleMap(
                        mapType: MapType.normal,
                        initialCameraPosition: initialLocation,
                        // polylines: _polyline,
                        markers: Set.of((marker != null) ? [marker] : []),
                        circles: Set.of((circle != null) ? [circle] : []),
                        onMapCreated: (GoogleMapController controller) {
                          // setPolylines();
                          _controller = controller;
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 10, left: 5),
                        child: StandardHeadingNoBg(
                            passedText: "Update order status"),
                      ),
                      Divider(height: 2, thickness: 2),
                      SizedBox(height: 15),
                      // >>>>>>>>>>>>>>>>>>>>>>>>>>  O R D E R   S T A T U S
                      Center(
                        child: SimpleGroupedChips<int>(
                          isMultiple: true,
                          preSelection: model.getOrderStatusPreSelectedList(
                              widget.passedOrder),
                          key: chipKey,
                          isScrolling: false,
                          values: _statusListValues,
                          itemTitle: _statusListText,
                          backgroundColorItem: Colors.black26,
                          onItemSelected: (selected) {
                            print("selected " + selected.toString());
                            setState(() {
                              _updatedStatusList = selected;
                            });
                            // _updatedStatusList.add(selected);

                            print("---> _updatedStatusList inside checkBox: " +
                                _updatedStatusList.toString());
                          },
                        ),
                      ),
                      _updatedStatusList != null
                          ? Center(
                              child: InkWell(
                                onTap: () async {
                                  bool result = await model.updateOrderStatus(
                                      _updatedStatusList,
                                      widget.passedOrder.orderID);
                                },
                                child: StandardLinkText(
                                  passedText: "Update status",
                                ),
                              ),
                            )
                          : Container(),
                    ],
                  ),
                ),
              ],
            ),
            model.state == ViewState.Busy ? Loading() : SizedBox()
          ],
        ),
      ),
    );
  }
}
