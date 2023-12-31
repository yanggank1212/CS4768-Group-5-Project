import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poutine_time/model/channel_model.dart';

class ChannelSidebar extends StatelessWidget {
  final List<ChannelModel> channels;
  final Function(String) onChannelSelected;
  final VoidCallback onTrendingSelected;

  ChannelSidebar(
      {required this.channels,
      required this.onChannelSelected,
      required this.onTrendingSelected});

  @override
  Widget build(BuildContext context) {
    // Define the theme colors
    Color primaryColor = Color(0xFF8C1D40); // Maroon-like color
    Color textColor = Colors.white;
    Color accentColor = Color(0xFFB1A7A6); // Accent grey

    return Drawer(
      child: Container(
        color: primaryColor, // Drawer background color
        child: ListView(
          children: [
            Text(
              "Channels",
              style: GoogleFonts.montserrat(
                  textStyle: TextStyle(
                color: textColor,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              )),
            ),
            SizedBox(
              height: 16,
            ),
            for (var channel in channels)
              ListTile(
                title: Text(
                  channel.name,
                  style: GoogleFonts.robotoCondensed(
                    textStyle: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                leading: Icon(channel.icon, color: textColor), // Sample icon
                onTap: () {
                  onChannelSelected(channel.id);
                  Navigator.pop(context);
                },
              ),
            SizedBox(
              height: 16,
            ),
            ListTile(
              title: Text(
                "Trending",
                style: GoogleFonts.robotoCondensed(
                  textStyle: TextStyle(
                    color: textColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              leading: Icon(Icons.trending_up, color: textColor), // Sample icon
              onTap: () {
                onTrendingSelected();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
