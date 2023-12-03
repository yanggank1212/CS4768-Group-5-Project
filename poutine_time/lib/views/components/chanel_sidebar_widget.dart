import 'package:flutter/material.dart';
import 'package:poutine_time/model/channel_model.dart';

class ChannelSidebar extends StatelessWidget {
  final List<ChannelModel> channels;
  final Function(String) onChannelSelected;

  ChannelSidebar({required this.channels, required this.onChannelSelected});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text('Channels'),
            onTap: () {},
          ),
          for (var channel in channels)
            ListTile(
              title: Text(channel.name),
              onTap: () {
                onChannelSelected(channel.id);
                Navigator.pop(context);
              },
            ),
        ],
      ),
    );
  }
}
