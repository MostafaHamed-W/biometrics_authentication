import 'package:biometrics_authentication/helpers/biometrics_helper.dart';
import 'package:biometrics_authentication/home/hidden_content_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    void navigateToHiddenContent() {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => const HiddenContentScreen(),
        ),
      );
      Fluttertoast.showToast(msg: 'Authenticated  ✅');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Biometrics Authentication Demo'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              const Divider(height: 70),
              ElevatedButton.icon(
                onPressed: () async {
                  final supportState = await BiometricsHelper.instance.checkDeviceIsSupported();
                  Fluttertoast.showToast(msg: supportState == SupportState.supported ? 'Device Supported ✅' : 'Device not Supported ❌');
                },
                label: const Text('Check device support'),
                icon: const Icon(Icons.mobile_friendly),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  final canCheckBiometrics = await BiometricsHelper.instance.canCheckBiometrics();
                  Fluttertoast.showToast(msg: canCheckBiometrics ? 'Can check biometrics ✅' : 'Cannot check biometrics ❌');
                },
                label: const Text('Check biometrics support'),
                icon: const Icon(Icons.check),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () async {
                  final availableBiometrics = await BiometricsHelper.instance.getAvailableBiometrics();
                  Fluttertoast.showToast(
                    timeInSecForIosWeb: 3,
                    toastLength: Toast.LENGTH_LONG,
                    msg: "${availableBiometrics.isEmpty ? [] : availableBiometrics}",
                  );
                },
                label: const Text('Get available biometrics'),
                icon: const Icon(Icons.list),
              ),
              const Divider(height: 70),
              ElevatedButton.icon(
                onPressed: () async {
                  final didAuthenticate = await BiometricsHelper.instance.authenticate(biometricOnly: false);
                  if (didAuthenticate) navigateToHiddenContent();
                },
                label: const Text('Show hidden content'),
                icon: const Icon(Icons.lock_open),
              ),
              const Divider(height: 70),
            ],
          ),
        ),
      ),
    );
  }
}
