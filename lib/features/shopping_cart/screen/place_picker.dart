import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:math' show Random;
import 'package:dio/dio.dart';
import 'package:fgi_y2j/config/style/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'google_map_mixin.dart';

class Uuid {
  final Random _random = Random();
  String generateV4() {
    var special = 8 + _random.nextInt(4);
    return '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}-'
        '${_bitsDigits(16, 4)}-'
        '4${_bitsDigits(12, 3)}-'
        '${_printDigits(special, 1)}${_bitsDigits(12, 3)}-'
        '${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}${_bitsDigits(16, 4)}';
  }
  String _bitsDigits(int bitCount, int digitCount) =>
      _printDigits(_generateBits(bitCount), digitCount);
  int _generateBits(int bitCount) => _random.nextInt(1 << bitCount);
  String _printDigits(int value, int count) =>
      value.toRadixString(16).padLeft(count, '0');
}
class LocationResult {
  String? name;
  String? locality;
  LatLng? latLng;
  String? street;
  String? country;
  String? state;
  String? city;
  String? zip;
}
class NearbyPlace {
  String? name;
  String? icon;
  LatLng? latLng;
}
class AutoCompleteItem {
  String? id;
  String? text;
  int? offset;
  int? length;
}
class PlacePicker extends StatefulWidget {
  final String? apiKey;
  const PlacePicker(this.apiKey, {super.key});
  @override
  State<StatefulWidget> createState() {
    return PlacePickerState();
  }
}
class PlacePickerState extends State<PlacePicker> with GoogleMapMixin {
  static const LatLng initialTarget = LatLng(5.5911921, -0.3198162);
  final Completer<GoogleMapController> mapController = Completer();
  final Set<Marker> markers = <Marker>{}..add(
      const Marker(
        position: initialTarget,
        markerId: MarkerId('selected-location'),
      ),
    );
  LocationResult? locationResult;
  OverlayEntry? overlayEntry;
  List<NearbyPlace> nearbyPlaces = [];
  String sessionToken = Uuid().generateV4();
  GlobalKey appBarKey = GlobalKey();
  bool hasSearchTerm = false;
  String previousSearchTerm = '';
  // constructor
  PlacePickerState();
  void onMapCreated(GoogleMapController controller) {
    mapController.complete(controller);
    setMapStyle(mapController.future);
    moveToCurrentUserLocation();
  }

  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        key: appBarKey,
        title: SearchInput(searchPlace),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.my_location),
          )
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 20,
          ),
          color: AppColors.primary,
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: initialTarget,
                zoom: 15,
              ),
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              onMapCreated: onMapCreated,
              onTap: (latLng) {
                clearOverlay();
                moveToLocation(latLng);
              },
              markers: markers,
            ),
          ),
          hasSearchTerm
              ? const SizedBox()
              : Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SelectPlaceAction(getLocationName(), () {
                        Navigator.of(context).pop(locationResult);
                      }),
                      const Divider(
                        height: 8,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 8,
                        ),
                        child: Text(
                          "Nearby Places",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: nearbyPlaces
                                .map((it) => NearbyPlaceItem(it, () {
                                      moveToLocation(it.latLng!);
                                    }))
                                .toList(),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
  void clearOverlay() {
    if (overlayEntry != null) {
      overlayEntry!.remove();
      overlayEntry = null;
    }
  }
  void searchPlace(String place) {
    // on keyboard dismissal, the search was being triggered again
    // this is to cap that.
    if (place == previousSearchTerm) {
      return;
    } else {
      previousSearchTerm = place;
    }

    clearOverlay();

    setState(() {
      hasSearchTerm = place.isNotEmpty;
    });

    if (place.isEmpty) {
      return;
    }

    final renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    final appBarBox =
        appBarKey.currentContext!.findRenderObject() as RenderBox?;

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: appBarBox!.size.height,
        width: size.width,
        child: Container(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 24,
          ),
          color: Colors.white,
          child:  Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: 20,
                width: Get.width*.8,
                child: const LinearProgressIndicator(
                  color: AppColors.primary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
    Overlay.of(context).insert(overlayEntry!);
    autoCompleteSearch(context, place);
  }
  void autoCompleteSearch(context, String place) {
    place = place.replaceAll(' ', '+');
    var endpoint =
        'https://maps.googleapis.com/maps/api/place/autocomplete/json?'
        'key=${widget.apiKey}&'
        'input=$place&sessiontoken=$sessionToken';

    if (locationResult != null) {
      endpoint += '&location=${locationResult!.latLng!.latitude},'
          '${locationResult!.latLng!.longitude}';
    }
    log("EndPoint : ${endpoint}");
    Dio().get(endpoint).then((response) {
      if (response.statusCode == 200) {
        log("LOcationResult : ${response.data}");
        Map<String, dynamic> data = response.data;
        var suggestions = <RichSuggestion>[];

        if (data['error_message'] == null) {
          List<dynamic> predictions = data['predictions'];

          if (predictions.isEmpty) {
            var aci = AutoCompleteItem();
            aci.text = " S.of(context).noResultFound";
            aci.offset = 0;
            aci.length = 0;

            suggestions.add(RichSuggestion(aci, () {}));
          } else {
            for (dynamic t in predictions) {
              var aci = AutoCompleteItem();

              aci.id = t['place_id'];
              aci.text = t['description'];
              aci.offset = t['matched_substrings'][0]['offset'];
              aci.length = t['matched_substrings'][0]['length'];

              suggestions.add(RichSuggestion(aci, () {
                FocusScope.of(context).requestFocus(FocusNode());
                decodeAndSelectPlace(aci.id);
              }));
            }
          }
        } else {
          var aci = AutoCompleteItem();
          aci.text = data['error_message'];
          aci.offset = 0;
          aci.length = 0;
          suggestions.add(RichSuggestion(aci, () {}));
        }
        displayAutoCompleteSuggestions(suggestions);
      }
    }).catchError((print) {});
  }
  void decodeAndSelectPlace(String? placeId) {
    clearOverlay();
    var endpoint =
        'https://maps.googleapis.com/maps/api/place/details/json?key=${widget.apiKey}'
        '&placeid=$placeId';
    Dio().get(endpoint).then((response) {
      if (response.statusCode == 200) {
        Map<String, dynamic> location =
            jsonDecode(response.data)['result']['geometry']['location'];
        var latLng = LatLng(location['lat'], location['lng']);
        moveToLocation(latLng);
      }
    });
  }

  /// Display autocomplete suggestions with the overlay.
  void displayAutoCompleteSuggestions(List<RichSuggestion> suggestions) {
    final renderBox = context.findRenderObject() as RenderBox;
    var size = renderBox.size;

    final appBarBox =
        appBarKey.currentContext!.findRenderObject() as RenderBox?;

    clearOverlay();

    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        width: size.width,
        top: appBarBox!.size.height,
        child: Container(
          color: Colors.grey.shade100,
          child: Column(
            children: suggestions,
          ),
        ),
      ),
    );

    Overlay.of(context).insert(overlayEntry!);
  }

  /// Utility function to get clean readable name of a location. First checks
  /// for a human-readable name from the nearby list. This helps in the cases
  /// that the user selects from the nearby list (and expects to see that as a
  /// result, instead of road name). If no name is found from the nearby list,
  /// then the road name returned is used instead.
  String? getLocationName() {
    if (locationResult == null || (locationResult!.name?.isEmpty ?? true)) {
      return 'Unnamed location';
    }

    for (var np in nearbyPlaces) {
      if (np.latLng == locationResult!.latLng) {
        locationResult!.name = np.name;
        return np.name;
      }
    }

    return '${locationResult!.name}, ${locationResult!.locality}';
  }

  /// Moves the marker to the indicated lat,lng
  void setMarker(LatLng latLng) {
    // markers.clear();
    setState(() {
      markers.clear();
      markers.add(
        Marker(
          markerId: const MarkerId('selected-location'),
          position: latLng,
        ),
      );
    });
  }

  /// Fetches and updates the nearby places to the provided lat,lng
  void getNearbyPlaces(LatLng latLng) {
    Dio()
        .get('https://maps.googleapis.com/maps/api/place/nearbysearch/json?'
            'key=${widget.apiKey}&'
            'location=${latLng.latitude},${latLng.longitude}&radius=150')
        .then((response) {
      if (response.statusCode == 200) {
        nearbyPlaces.clear();
        for (Map<String, dynamic> item
            in jsonDecode(response.data)['results']) {
          var nearbyPlace = NearbyPlace();

          nearbyPlace.name = item['name'];
          nearbyPlace.icon = item['icon'];
          double latitude = item['geometry']['location']['lat'];
          double longitude = item['geometry']['location']['lng'];

          var latLng = LatLng(latitude, longitude);

          nearbyPlace.latLng = latLng;

          nearbyPlaces.add(nearbyPlace);
        }
      }

      // to update the nearby places
      setState(() {
        // this is to require the result to show
        hasSearchTerm = false;
      });
    }).catchError((error) {});
  }

  /// This method gets the human readable name of the location. Mostly appears
  /// to be the road name and the locality.
  void reverseGeocodeLatLng(LatLng latLng) {
    Dio()
        .get(
            'https://maps.googleapis.com/maps/api/geocode/json?latlng=${latLng.latitude},${latLng.longitude}&key=${widget.apiKey}')
        .then((response) {
      Map<String, dynamic> responseJson = jsonDecode(response.data);
      if (response.statusCode == 200 &&
          responseJson['results'] is List &&
          List.from(responseJson['results']).isNotEmpty) {
        String? road = '';
        String? locality = '';

        String? number = '';
        String? street = '';
        String? state = '';

        String? city = '';
        String? country = '';
        String? zip = '';

        List components = responseJson['results'][0]['address_components'];
        for (var i = 0; i < components.length; i++) {
          final item = components[i];
          List types = item['types'];
          if (types.contains('street_number') ||
              types.contains('premise') ||
              types.contains('sublocality') ||
              types.contains('sublocality_level_2')) {
            if (number!.isEmpty) {
              number = item['long_name'];
            }
          }
          if (types.contains('route') || types.contains('neighborhood')) {
            if (street!.isEmpty) {
              street = item['long_name'];
            }
          }
          if (types.contains('administrative_area_level_1')) {
            state = item['short_name'];
          }
          if (types.contains('administrative_area_level_2') ||
              types.contains('administrative_area_level_3')) {
            if (city!.isEmpty) {
              city = item['long_name'];
            }
          }
          if (types.contains('locality')) {
            if (locality!.isEmpty) {
              locality = item['short_name'];
            }
          }
          if (types.contains('route')) {
            if (road!.isEmpty) {
              road = item['long_name'];
            }
          }
          if (types.contains('country')) {
            country = item['short_name'];
            if (types.contains('postal_code')) {
              if (zip!.isEmpty) {
                zip = item['long_name'];
              }
            }
          }

          setState(() {
            locationResult = LocationResult();
            locationResult!.name = road;
            locationResult!.locality = locality;
            locationResult!.latLng = latLng;
            locationResult!.street = '$number $street';
            locationResult!.state = state;
            locationResult!.city = city;
            locationResult!.country = country;
            locationResult!.zip = zip;
          });
        }
      } else {
        setState(() {
          locationResult = LocationResult();
          locationResult!.name = '';
          locationResult!.latLng = latLng;
          locationResult!.street = '';
          locationResult!.state = '';
          locationResult!.city = '';
          locationResult!.country = '';
          locationResult!.zip = '';
        });
      }
    });
  }

  /// Moves the camera to the provided location and updates other UI features to
  /// match the location.
  void moveToLocation(LatLng latLng) {
    mapController.future.then((controller) {
      controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: latLng,
            zoom: 15.0,
          ),
        ),
      );
    });

    setMarker(latLng);

    reverseGeocodeLatLng(latLng);

    getNearbyPlaces(latLng);
  }

  void moveToCurrentUserLocation() {
    var location = Location();
    location.getLocation().then((locationData) {
      var target = LatLng(locationData.latitude!, locationData.longitude!);
      moveToLocation(target);
    });
  }
}

/// Custom Search input field, showing the search and clear icons.
class SearchInput extends StatefulWidget {
  final ValueChanged<String> onSearchInput;

  const SearchInput(this.onSearchInput);

  @override
  State<StatefulWidget> createState() {
    return SearchInputState();
  }
}

class SearchInputState extends State<SearchInput> {
  TextEditingController editController = TextEditingController();

  Timer? debouncer;

  bool hasSearchEntry = false;

  SearchInputState();

  @override
  void initState() {
    super.initState();
    editController.addListener(onSearchInputChange);
  }

  @override
  void dispose() {
    editController.removeListener(onSearchInputChange);
    editController.dispose();

    super.dispose();
  }

  void onSearchInputChange() {
    if (editController.text.isEmpty) {
      debouncer?.cancel();
      widget.onSearchInput(editController.text);
      return;
    }

    if (debouncer?.isActive ?? false) {
      debouncer!.cancel();
    }

    debouncer = Timer(const Duration(milliseconds: 500), () {
      widget.onSearchInput(editController.text);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 6,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.grey.shade200,
      ),
      child: Row(
        children: <Widget>[
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              decoration: const InputDecoration(
                hintText: "Search Location Here",
                border: InputBorder.none,
              ),
              controller: editController,
              onChanged: (value) {
                setState(() {
                  hasSearchEntry = value.isNotEmpty;
                });
              },
            ),
          ),
          const SizedBox(
            width: 8,
          ),
          hasSearchEntry
              ? GestureDetector(
                  onTap: () {
                    editController.clear();
                    setState(() {
                      hasSearchEntry = false;
                    });
                  },
                  child: const Icon(
                    Icons.clear,
                  ),
                )
              : const SizedBox(),
        ],
      ),
    );
  }
}

class SelectPlaceAction extends StatelessWidget {
  final String? locationName;
  final VoidCallback onTap;

  const SelectPlaceAction(this.locationName, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    locationName!,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                  const Text(
                    "Tap Select Location",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward,
            )
          ],
        ),
      ),
    );
  }
}

class NearbyPlaceItem extends StatelessWidget {
  final NearbyPlace nearbyPlace;
  final VoidCallback onTap;

  const NearbyPlaceItem(this.nearbyPlace, this.onTap);

  @override
  Widget build(BuildContext context) {
    return InkResponse(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: Row(
          children: <Widget>[
            Image.network(
              nearbyPlace.icon!,
              width: 16,
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Text(
                nearbyPlace.name.toString(),
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RichSuggestion extends StatelessWidget {
  final VoidCallback onTap;
  final AutoCompleteItem autoCompleteItem;

  const RichSuggestion(this.autoCompleteItem, this.onTap, {super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
          vertical: 16,
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              child: RichText(
                text: TextSpan(children: getStyledTexts(context)),
              ),
            )
          ],
        ),
      ),
    );
  }

  List<TextSpan> getStyledTexts(BuildContext context) {
    final result = <TextSpan>[];

    final startText =
        autoCompleteItem.text!.substring(0, autoCompleteItem.offset);
    if (startText.isNotEmpty) {
      result.add(
        TextSpan(
          text: startText,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 15,
          ),
        ),
      );
    }

    final boldText = autoCompleteItem.text!.substring(autoCompleteItem.offset!,
        autoCompleteItem.offset! + autoCompleteItem.length!);

    result.add(TextSpan(
      text: boldText,
      style: const TextStyle(
        color: Colors.red,
        fontSize: 15,
      ),
    ));

    var remainingText = autoCompleteItem.text!
        .substring(autoCompleteItem.offset! + autoCompleteItem.length!);
    result.add(
      TextSpan(
        text: remainingText,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 15,
        ),
      ),
    );

    return result;
  }
}
