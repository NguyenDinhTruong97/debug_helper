import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../debug_helper.dart';
import '../widgets/base_scaffold.dart';

class DeviceInfo extends StatelessWidget {
  const DeviceInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final data = DebugHelper.getInstance().deviceData;

    return BaseScaffold(
      title: "Device Information",
      body: data == null
          ? const Center(
              child: Text("No Device Data"),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  _DataTile(label: "Device Name", content: data.deviceName),
                  _DataTile(label: "Device Agent", content: data.deviceAgent),
                  _DataTile(label: "Device UUID", content: data.deviceUUID),
                  _DataTile(label: "Platform", content: data.platform),
                  _DataTile(label: "OS Version", content: data.osVersion),
                  _DataTile(
                      label: "Firebase Install Id",
                      content: data.firebaseInstallationId),
                ],
              ),
            ),
    );
  }
}

class _DataTile extends StatelessWidget {
  const _DataTile({required this.label, required this.content});

  final String label;
  final String content;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onLongPress: () {
        Clipboard.setData(ClipboardData(text: content));
        showToast(context, msg: 'Copied');
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                Text(label),
                const SizedBox(width: 16),
                Expanded(child: Text(content)),
              ],
            ),
            const Divider(
              color: Colors.grey,
              height: 1,
            )
          ],
        ),
      ),
    );
  }

  void showToast(BuildContext context, {required String msg}) {
    final snackBar = SnackBar(content: Text(msg));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
