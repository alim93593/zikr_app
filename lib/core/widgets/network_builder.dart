import 'package:flutter/material.dart';

import '../network/network_info.dart';

/// Widget that builds based on network connectivity state.
class NetworkBuilder extends StatefulWidget {
  final WidgetBuilder onlineBuilder;
  final WidgetBuilder offlineBuilder;
  final NetworkInfo networkInfo;

  const NetworkBuilder({
    super.key,
    required this.onlineBuilder,
    required this.offlineBuilder,
    required this.networkInfo,
  });

  @override
  State<NetworkBuilder> createState() => _NetworkBuilderState();
}

class _NetworkBuilderState extends State<NetworkBuilder> {
  bool _connected = true;

  @override
  void initState() {
    super.initState();
    _check();
  }

  Future<void> _check() async {
    final isConnected = await widget.networkInfo.isConnected;
    if (mounted) setState(() => _connected = isConnected);
  }

  @override
  Widget build(BuildContext context) {
    return _connected
        ? widget.onlineBuilder(context)
        : widget.offlineBuilder(context);
  }
}
