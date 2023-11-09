/// This is the Post Widget Component holding all the Post Model variables to be displayed

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class PostWidget extends StatelessWidget {
  //This would need a parameter of Post Model
  //Post Model Variables

  String _description =
      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer et mi elit. Fusce metus dolor, efficitur id arcu sed, dapibus hendrerit dolor. Nam fringilla iaculis dui sit amet dapibus. Aliquam iaculis lorem eget lacus congue, eu laoreet tortor tempus. Maecenas interdum nulla ligula, at sollicitudin ante volutpat quis. Nam fermentum ut nisi id fringilla. Cras venenatis id nunc ut dictum. Etiam volutpat interdum suscipit. Nulla auctor sit amet nisi facilisis pharetra. Integer leo est, feugiat eu lorem sed, elementum mattis diam. Nunc pellentesque scelerisque vulputate. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Nunc in nisi arcu. Cras vel ipsum porttitor, malesuada sapien a, volutpat magna. Donec sit amet diam nec eros aliquam porttitor eu sed turpis. Duis sed vehicula urna, vitae semper quam. In sollicitudin pharetra ipsum sed bibendum. Sed interdum vehicula metus, in.";
  DateTime _date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    const String _username = "John Doe";
    final String _formattedDate = DateFormat('dd-MM-yyyy').format(_date);

    return Container(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          //Top Container
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xff000000)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text(
                  _username,
                  style: TextStyle(
                    fontFamily: 'JetBrains Mono',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.1000000409,
                    letterSpacing: 2.1,
                    color: Color(0xff000000),
                  ),
                ),
                SizedBox(
                    // Post Options Button
                    width: 32,
                    height: 32,
                    child: IconButton(
                      icon: Image.asset(
                        'assets/icons/post-options.png',
                      ),
                      onPressed: () {},
                    )),
              ],
            ),
          ),
          // Middle Container
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xff000000)),
            ),
            child: SizedBox(
              width: double.infinity,
              child: Container(
                constraints: const BoxConstraints(
                  maxWidth: 370,
                ),
                child: Text(
                  _description,
                  style: const TextStyle(
                    fontFamily: 'JetBrains Mono',
                    fontSize: 15,
                    fontWeight: FontWeight.w400,
                    height: 1.1,
                    color: Color(0xff000000),
                  ),
                ),
              ),
            ),
          ),
          // Bottom Container
          Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            //width: double.infinity,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xff000000)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  child: Row(
                    children: [
                      Container(
                        width: 32,
                        height: 32,
                        child: IconButton(
                          icon: Image.asset(
                            'assets/icons/thumbup.png',
                          ),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: 16),
                      Container(
                        width: 32,
                        height: 32,
                        child: IconButton(
                          icon: Image.asset(
                            'assets/icons/thumbdown.png',
                          ),
                          onPressed: () {},
                        ),
                      ),
                      SizedBox(width: 16),
                      Container(
                        width: 32,
                        height: 32,
                        child: IconButton(
                          icon: Image.asset(
                            'assets/icons/chatbubble.png',
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
                Text(
                  //Post's Release Date
                  _formattedDate,
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontFamily: 'JetBrains Mono',
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 1.1,
                    letterSpacing: 2.1,
                    color: Color(0xff000000),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
