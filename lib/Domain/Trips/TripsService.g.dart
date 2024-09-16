// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TripsService.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$tripsListHash() => r'979c649dfb4d77139b4f92122a7c2a333cb04bf6';

/// See also [tripsList].
@ProviderFor(tripsList)
final tripsListProvider = AutoDisposeFutureProvider<TripDataResponse>.internal(
  tripsList,
  name: r'tripsListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$tripsListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TripsListRef = AutoDisposeFutureProviderRef<TripDataResponse>;
String _$truckDriverHash() => r'f77449b931748bc0e18b4e67a336372de97fc55c';

/// See also [truckDriver].
@ProviderFor(truckDriver)
final truckDriverProvider =
    AutoDisposeFutureProvider<TruckDriverResponse>.internal(
  truckDriver,
  name: r'truckDriverProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$truckDriverHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TruckDriverRef = AutoDisposeFutureProviderRef<TruckDriverResponse>;
String _$tripDataHash() => r'770a451fbfb02629062c177bca28d408cce61782';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [tripData].
@ProviderFor(tripData)
const tripDataProvider = TripDataFamily();

/// See also [tripData].
class TripDataFamily extends Family<AsyncValue<BiltyResponseData>> {
  /// See also [tripData].
  const TripDataFamily();

  /// See also [tripData].
  TripDataProvider call({
    required String? tripRequestid,
  }) {
    return TripDataProvider(
      tripRequestid: tripRequestid,
    );
  }

  @override
  TripDataProvider getProviderOverride(
    covariant TripDataProvider provider,
  ) {
    return call(
      tripRequestid: provider.tripRequestid,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'tripDataProvider';
}

/// See also [tripData].
class TripDataProvider extends AutoDisposeFutureProvider<BiltyResponseData> {
  /// See also [tripData].
  TripDataProvider({
    required String? tripRequestid,
  }) : this._internal(
          (ref) => tripData(
            ref as TripDataRef,
            tripRequestid: tripRequestid,
          ),
          from: tripDataProvider,
          name: r'tripDataProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$tripDataHash,
          dependencies: TripDataFamily._dependencies,
          allTransitiveDependencies: TripDataFamily._allTransitiveDependencies,
          tripRequestid: tripRequestid,
        );

  TripDataProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tripRequestid,
  }) : super.internal();

  final String? tripRequestid;

  @override
  Override overrideWith(
    FutureOr<BiltyResponseData> Function(TripDataRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: TripDataProvider._internal(
        (ref) => create(ref as TripDataRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tripRequestid: tripRequestid,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<BiltyResponseData> createElement() {
    return _TripDataProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is TripDataProvider && other.tripRequestid == tripRequestid;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tripRequestid.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin TripDataRef on AutoDisposeFutureProviderRef<BiltyResponseData> {
  /// The parameter `tripRequestid` of this provider.
  String? get tripRequestid;
}

class _TripDataProviderElement
    extends AutoDisposeFutureProviderElement<BiltyResponseData>
    with TripDataRef {
  _TripDataProviderElement(super.provider);

  @override
  String? get tripRequestid => (origin as TripDataProvider).tripRequestid;
}

String _$updateTruckDriverHash() => r'3b5d0722663c9ec93788f31100609408aabc35f0';

/// See also [updateTruckDriver].
@ProviderFor(updateTruckDriver)
const updateTruckDriverProvider = UpdateTruckDriverFamily();

/// See also [updateTruckDriver].
class UpdateTruckDriverFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [updateTruckDriver].
  const UpdateTruckDriverFamily();

  /// See also [updateTruckDriver].
  UpdateTruckDriverProvider call({
    String? truckId,
    String? driverId,
    String? tripRequestId,
  }) {
    return UpdateTruckDriverProvider(
      truckId: truckId,
      driverId: driverId,
      tripRequestId: tripRequestId,
    );
  }

  @override
  UpdateTruckDriverProvider getProviderOverride(
    covariant UpdateTruckDriverProvider provider,
  ) {
    return call(
      truckId: provider.truckId,
      driverId: provider.driverId,
      tripRequestId: provider.tripRequestId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateTruckDriverProvider';
}

/// See also [updateTruckDriver].
class UpdateTruckDriverProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [updateTruckDriver].
  UpdateTruckDriverProvider({
    String? truckId,
    String? driverId,
    String? tripRequestId,
  }) : this._internal(
          (ref) => updateTruckDriver(
            ref as UpdateTruckDriverRef,
            truckId: truckId,
            driverId: driverId,
            tripRequestId: tripRequestId,
          ),
          from: updateTruckDriverProvider,
          name: r'updateTruckDriverProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateTruckDriverHash,
          dependencies: UpdateTruckDriverFamily._dependencies,
          allTransitiveDependencies:
              UpdateTruckDriverFamily._allTransitiveDependencies,
          truckId: truckId,
          driverId: driverId,
          tripRequestId: tripRequestId,
        );

  UpdateTruckDriverProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.truckId,
    required this.driverId,
    required this.tripRequestId,
  }) : super.internal();

  final String? truckId;
  final String? driverId;
  final String? tripRequestId;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(UpdateTruckDriverRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateTruckDriverProvider._internal(
        (ref) => create(ref as UpdateTruckDriverRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        truckId: truckId,
        driverId: driverId,
        tripRequestId: tripRequestId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _UpdateTruckDriverProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateTruckDriverProvider &&
        other.truckId == truckId &&
        other.driverId == driverId &&
        other.tripRequestId == tripRequestId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, truckId.hashCode);
    hash = _SystemHash.combine(hash, driverId.hashCode);
    hash = _SystemHash.combine(hash, tripRequestId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UpdateTruckDriverRef
    on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `truckId` of this provider.
  String? get truckId;

  /// The parameter `driverId` of this provider.
  String? get driverId;

  /// The parameter `tripRequestId` of this provider.
  String? get tripRequestId;
}

class _UpdateTruckDriverProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with UpdateTruckDriverRef {
  _UpdateTruckDriverProviderElement(super.provider);

  @override
  String? get truckId => (origin as UpdateTruckDriverProvider).truckId;
  @override
  String? get driverId => (origin as UpdateTruckDriverProvider).driverId;
  @override
  String? get tripRequestId =>
      (origin as UpdateTruckDriverProvider).tripRequestId;
}

String _$startTripHash() => r'befe443952e5b4d9098f6e24ea914e63d8ea52dc';

/// See also [startTrip].
@ProviderFor(startTrip)
const startTripProvider = StartTripFamily();

/// See also [startTrip].
class StartTripFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [startTrip].
  const StartTripFamily();

  /// See also [startTrip].
  StartTripProvider call({
    String? tripRequestId,
  }) {
    return StartTripProvider(
      tripRequestId: tripRequestId,
    );
  }

  @override
  StartTripProvider getProviderOverride(
    covariant StartTripProvider provider,
  ) {
    return call(
      tripRequestId: provider.tripRequestId,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'startTripProvider';
}

/// See also [startTrip].
class StartTripProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [startTrip].
  StartTripProvider({
    String? tripRequestId,
  }) : this._internal(
          (ref) => startTrip(
            ref as StartTripRef,
            tripRequestId: tripRequestId,
          ),
          from: startTripProvider,
          name: r'startTripProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$startTripHash,
          dependencies: StartTripFamily._dependencies,
          allTransitiveDependencies: StartTripFamily._allTransitiveDependencies,
          tripRequestId: tripRequestId,
        );

  StartTripProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tripRequestId,
  }) : super.internal();

  final String? tripRequestId;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(StartTripRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: StartTripProvider._internal(
        (ref) => create(ref as StartTripRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tripRequestId: tripRequestId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _StartTripProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is StartTripProvider && other.tripRequestId == tripRequestId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tripRequestId.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin StartTripRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `tripRequestId` of this provider.
  String? get tripRequestId;
}

class _StartTripProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with StartTripRef {
  _StartTripProviderElement(super.provider);

  @override
  String? get tripRequestId => (origin as StartTripProvider).tripRequestId;
}

String _$endTripHash() => r'727924de373ccd1cf74ddabf8a4c0ddd294d9724';

/// See also [endTrip].
@ProviderFor(endTrip)
const endTripProvider = EndTripFamily();

/// See also [endTrip].
class EndTripFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [endTrip].
  const EndTripFamily();

  /// See also [endTrip].
  EndTripProvider call({
    String? tripRequestId,
    String? kantaWeight,
    String? bags,
    String? kantaImage,
    String? qualityImage,
  }) {
    return EndTripProvider(
      tripRequestId: tripRequestId,
      kantaWeight: kantaWeight,
      bags: bags,
      kantaImage: kantaImage,
      qualityImage: qualityImage,
    );
  }

  @override
  EndTripProvider getProviderOverride(
    covariant EndTripProvider provider,
  ) {
    return call(
      tripRequestId: provider.tripRequestId,
      kantaWeight: provider.kantaWeight,
      bags: provider.bags,
      kantaImage: provider.kantaImage,
      qualityImage: provider.qualityImage,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'endTripProvider';
}

/// See also [endTrip].
class EndTripProvider extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [endTrip].
  EndTripProvider({
    String? tripRequestId,
    String? kantaWeight,
    String? bags,
    String? kantaImage,
    String? qualityImage,
  }) : this._internal(
          (ref) => endTrip(
            ref as EndTripRef,
            tripRequestId: tripRequestId,
            kantaWeight: kantaWeight,
            bags: bags,
            kantaImage: kantaImage,
            qualityImage: qualityImage,
          ),
          from: endTripProvider,
          name: r'endTripProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$endTripHash,
          dependencies: EndTripFamily._dependencies,
          allTransitiveDependencies: EndTripFamily._allTransitiveDependencies,
          tripRequestId: tripRequestId,
          kantaWeight: kantaWeight,
          bags: bags,
          kantaImage: kantaImage,
          qualityImage: qualityImage,
        );

  EndTripProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.tripRequestId,
    required this.kantaWeight,
    required this.bags,
    required this.kantaImage,
    required this.qualityImage,
  }) : super.internal();

  final String? tripRequestId;
  final String? kantaWeight;
  final String? bags;
  final String? kantaImage;
  final String? qualityImage;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(EndTripRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: EndTripProvider._internal(
        (ref) => create(ref as EndTripRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        tripRequestId: tripRequestId,
        kantaWeight: kantaWeight,
        bags: bags,
        kantaImage: kantaImage,
        qualityImage: qualityImage,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _EndTripProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is EndTripProvider &&
        other.tripRequestId == tripRequestId &&
        other.kantaWeight == kantaWeight &&
        other.bags == bags &&
        other.kantaImage == kantaImage &&
        other.qualityImage == qualityImage;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, tripRequestId.hashCode);
    hash = _SystemHash.combine(hash, kantaWeight.hashCode);
    hash = _SystemHash.combine(hash, bags.hashCode);
    hash = _SystemHash.combine(hash, kantaImage.hashCode);
    hash = _SystemHash.combine(hash, qualityImage.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin EndTripRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `tripRequestId` of this provider.
  String? get tripRequestId;

  /// The parameter `kantaWeight` of this provider.
  String? get kantaWeight;

  /// The parameter `bags` of this provider.
  String? get bags;

  /// The parameter `kantaImage` of this provider.
  String? get kantaImage;

  /// The parameter `qualityImage` of this provider.
  String? get qualityImage;
}

class _EndTripProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with EndTripRef {
  _EndTripProviderElement(super.provider);

  @override
  String? get tripRequestId => (origin as EndTripProvider).tripRequestId;
  @override
  String? get kantaWeight => (origin as EndTripProvider).kantaWeight;
  @override
  String? get bags => (origin as EndTripProvider).bags;
  @override
  String? get kantaImage => (origin as EndTripProvider).kantaImage;
  @override
  String? get qualityImage => (origin as EndTripProvider).qualityImage;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
