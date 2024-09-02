// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AuthenticationService.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$verifyOtpHash() => r'22b73d3eca7a3f7977567273356a098f3d311be8';

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
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member