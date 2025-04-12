import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

enum SupportState { unknown, supported, unsupported }

class BiometricsHelper {
  BiometricsHelper._();
  static final instance = BiometricsHelper._();
  final LocalAuthentication _auth = LocalAuthentication();

  Future<SupportState> checkDeviceIsSupported() async {
    try {
      final bool isDeviceSupported = await _auth.isDeviceSupported();
      return isDeviceSupported ? SupportState.supported : SupportState.unsupported;
    } catch (e) {
      log("Device does not support biometrics: ${e.toString()}");
      return SupportState.unknown;
    }
  }

  Future<bool> canCheckBiometrics() async {
    try {
      final canCheckBiometrics = await _auth.canCheckBiometrics;
      return canCheckBiometrics;
    } on PlatformException catch (e) {
      log("Error checking biometrics: ${e.message}");
      return false;
    }
  }

  Future<List<BiometricType>> getAvailableBiometrics() async {
    try {
      final List<BiometricType> availableBiometrics = await _auth.getAvailableBiometrics();
      return availableBiometrics;
    } on PlatformException catch (e) {
      log("Error getting biometrics: ${e.message}");
      return [];
    }
  }

  Future<bool> authenticate({required bool biometricOnly}) async {
    try {
      return await _auth.authenticate(
        localizedReason: biometricOnly ? 'Scan your fingerprint (or face) to authenticate' : 'Let OS determine authentication method',
        options: AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: biometricOnly,
        ),
      );
    } on PlatformException catch (e) {
      log("Authentication error: ${e.message}");
      return false;
    }
  }

  Future<void> cancelAuthentication() async {
    await _auth.stopAuthentication();
  }
}
