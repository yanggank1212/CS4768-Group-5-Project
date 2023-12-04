import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:poutine_time/model/channel_model.dart';

List<ChannelModel> channels = [
  ChannelModel(id: '1', name: 'General', icon: MdiIcons.group),
  ChannelModel(id: '2', name: 'Education', icon: MdiIcons.school),
  ChannelModel(
      id: '3', name: 'Clubs & Society', icon: MdiIcons.globeLightOutline),
  ChannelModel(id: '4', name: 'Sports', icon: MdiIcons.soccer),
  ChannelModel(id: '5', name: 'Arts & Culture', icon: MdiIcons.palette),
];
