// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AuthenticationService.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$verifyOtpHash() => r'd0b62b86030ae4bc456bd00b5da0b9ffdf15df18';

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

/// See also [verifyOtp].
@ProviderFor(verifyOtp)
const verifyOtpProvider = VerifyOtpFamily();

/// See also [verifyOtp].
class VerifyOtpFamily extends Family<AsyncValue<LoginResponseModel>> {
  /// See also [verifyOtp].
  const VerifyOtpFamily();

  /// See also [verifyOtp].
  VerifyOtpProvider call({
    required String? number,
    required String? otp,
  }) {
    return VerifyOtpProvider(
      number: number,
      otp: otp,
    );
  }

  @override
  VerifyOtpProvider getProviderOverride(
    covariant VerifyOtpProvider provider,
  ) {
    return call(
      number: provider.number,
      otp: provider.otp,
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
  String? get name => r'verifyOtpProvider';
}

/// See also [verifyOtp].
class VerifyOtpProvider extends AutoDisposeFutureProvider<LoginResponseModel> {
  /// See also [verifyOtp].
  VerifyOtpProvider({
    required String? number,
    required String? otp,
  }) : this._internal(
          (ref) => verifyOtp(
            ref as VerifyOtpRef,
            number: number,
            otp: otp,
          ),
          from: verifyOtpProvider,
          name: r'verifyOtpProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$verifyOtpHash,
          dependencies: VerifyOtpFamily._dependencies,
          allTransitiveDependencies: VerifyOtpFamily._allTransitiveDependencies,
          number: number,
          otp: otp,
        );

  VerifyOtpProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.number,
    required this.otp,
  }) : super.internal();

  final String? number;
  final String? otp;

  @override
  Override overrideWith(
    FutureOr<LoginResponseModel> Function(VerifyOtpRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: VerifyOtpProvider._internal(
        (ref) => create(ref as VerifyOtpRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        number: number,
        otp: otp,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<LoginResponseModel> createElement() {
    return _VerifyOtpProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is VerifyOtpProvider &&
        other.number == number &&
        other.otp == otp;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, number.hashCode);
    hash = _SystemHash.combine(hash, otp.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin VerifyOtpRef on AutoDisposeFutureProviderRef<LoginResponseModel> {
  /// The parameter `number` of this provider.
  String? get number;

  /// The parameter `otp` of this provider.
  String? get otp;
}

class _VerifyOtpProviderElement
    extends AutoDisposeFutureProviderElement<LoginResponseModel>
    with VerifyOtpRef {
  _VerifyOtpProviderElement(super.provider);

  @override
  String? get number => (origin as VerifyOtpProvider).number;
  @override
  String? get otp => (origin as VerifyOtpProvider).otp;
}

String _$sendOtpHash() => r'9bbe040a284373e285e20dc0bb3f7d901fc37776';

/// See also [sendOtp].
@ProviderFor(sendOtp)
const sendOtpProvider = SendOtpFamily();

/// See also [sendOtp].
class SendOtpFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [sendOtp].
  const SendOtpFamily();

  /// See also [sendOtp].
  SendOtpProvider call({
    String? number,
  }) {
    return SendOtpProvider(
      number: number,
    );
  }

  @override
  SendOtpProvider getProviderOverride(
    covariant SendOtpProvider provider,
  ) {
    return call(
      number: provider.number,
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
  String? get name => r'sendOtpProvider';
}

/// See also [sendOtp].
class SendOtpProvider extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [sendOtp].
  SendOtpProvider({
    String? number,
  }) : this._internal(
          (ref) => sendOtp(
            ref as SendOtpRef,
            number: number,
          ),
          from: sendOtpProvider,
          name: r'sendOtpProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$sendOtpHash,
          dependencies: SendOtpFamily._dependencies,
          allTransitiveDependencies: SendOtpFamily._allTransitiveDependencies,
          number: number,
        );

  SendOtpProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.number,
  }) : super.internal();

  final String? number;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(SendOtpRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SendOtpProvider._internal(
        (ref) => create(ref as SendOtpRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        number: number,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _SendOtpProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SendOtpProvider && other.number == number;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, number.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SendOtpRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `number` of this provider.
  String? get number;
}

class _SendOtpProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with SendOtpRef {
  _SendOtpProviderElement(super.provider);

  @override
  String? get number => (origin as SendOtpProvider).number;
}

String _$registerUserHash() => r'4e5c8a00d61875818f8d123f8d5ab668fcfaca5f';

/// See also [registerUser].
@ProviderFor(registerUser)
const registerUserProvider = RegisterUserFamily();

/// See also [registerUser].
class RegisterUserFamily extends Family<AsyncValue<Map<String, dynamic>>> {
  /// See also [registerUser].
  const RegisterUserFamily();

  /// See also [registerUser].
  RegisterUserProvider call({
    Map<String, dynamic>? data,
  }) {
    return RegisterUserProvider(
      data: data,
    );
  }

  @override
  RegisterUserProvider getProviderOverride(
    covariant RegisterUserProvider provider,
  ) {
    return call(
      data: provider.data,
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
  String? get name => r'registerUserProvider';
}

/// See also [registerUser].
class RegisterUserProvider
    extends AutoDisposeFutureProvider<Map<String, dynamic>> {
  /// See also [registerUser].
  RegisterUserProvider({
    Map<String, dynamic>? data,
  }) : this._internal(
          (ref) => registerUser(
            ref as RegisterUserRef,
            data: data,
          ),
          from: registerUserProvider,
          name: r'registerUserProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$registerUserHash,
          dependencies: RegisterUserFamily._dependencies,
          allTransitiveDependencies:
              RegisterUserFamily._allTransitiveDependencies,
          data: data,
        );

  RegisterUserProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.data,
  }) : super.internal();

  final Map<String, dynamic>? data;

  @override
  Override overrideWith(
    FutureOr<Map<String, dynamic>> Function(RegisterUserRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: RegisterUserProvider._internal(
        (ref) => create(ref as RegisterUserRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        data: data,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<Map<String, dynamic>> createElement() {
    return _RegisterUserProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is RegisterUserProvider && other.data == data;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, data.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin RegisterUserRef on AutoDisposeFutureProviderRef<Map<String, dynamic>> {
  /// The parameter `data` of this provider.
  Map<String, dynamic>? get data;
}

class _RegisterUserProviderElement
    extends AutoDisposeFutureProviderElement<Map<String, dynamic>>
    with RegisterUserRef {
  _RegisterUserProviderElement(super.provider);

  @override
  Map<String, dynamic>? get data => (origin as RegisterUserProvider).data;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
