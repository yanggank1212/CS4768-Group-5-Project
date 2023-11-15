import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poutine_time/model/post_model.dart';
import 'package:poutine_time/views/commenting_page.dart';
import 'package:poutine_time/views/post_page.dart';

class PostWidget extends StatelessWidget {
  final PostModel postModel;
  bool displayUsername;
  bool displayPostOption;
  bool displayInteractions;
  bool displayReleaseDate;

  PostWidget({
    super.key,
    required this.postModel,
    this.displayUsername = false,
    this.displayPostOption = false,
    this.displayInteractions = false,
    this.displayReleaseDate = false,
  });

  void onThumbsUpPressed() {
    //Check if userID in the likes list
    //  Remove userID in the likes list
    //else
    //  Check if userID in dislikes list
    //    Remove userID in dislikes list
    //  Add userID in likes list
    print("Liked");
  }

  void onThumbsDownPressed() {
    //Check if userID in the dislikes list
    //  Remove userID in the dislikes list
    //else
    //  Check if userID in the likes list
    //    Remove userID in likes list
    //  Add userID in likes list
    print("Disliked");
  }

  Widget topCointainerWidget(bool displayUsername, bool displayPostOption) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (displayUsername)
            Text(
              postModel.username,
              style: const TextStyle(
                fontFamily: 'JetBrains Mono',
                fontSize: 14,
                fontWeight: FontWeight.w400,
                height: 1.1000000409,
                letterSpacing: 2.1,
                color: Color(0xff000000),
              ),
            ),
          if (displayPostOption)
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
    );
  }

  Widget middleContainerWidget() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: SizedBox(
        width: double.infinity,
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 370,
          ),
          child: Text(
            postModel.description,
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
    );
  }

  Widget bottomContainerWidget(
      BuildContext context, bool displayInteractions, bool displayReleaseDate) {
    String formattedDate =
        DateFormat('dd-MM-yyyy').format(postModel.release_date);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      //width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          // Interaction Buttons
          if (displayInteractions)
            Container(
              child: Row(
                children: [
                  // Thumbs Up
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: IconButton(
                      icon: Image.asset(
                        'assets/icons/thumbup.png',
                      ),
                      onPressed: onThumbsUpPressed,
                    ),
                  ),
                  const SizedBox(width: 4),
                  // Thumbs Up #
                  SizedBox(
                    width: 32,
                    height: 16,
                    child: Text(postModel.likes.length.toString()),
                  ),
                  const SizedBox(width: 4),
                  // Thumbs Down
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: IconButton(
                      icon: Image.asset(
                        'assets/icons/thumbdown.png',
                      ),
                      onPressed: onThumbsDownPressed,
                    ),
                  ),
                  const SizedBox(width: 4),
                  // Thumbs Down #
                  SizedBox(
                    width: 32,
                    height: 16,
                    child: Text(postModel.dislikes.length.toString()),
                  ),
                  const SizedBox(width: 4),
                  //Comment
                  SizedBox(
                    width: 32,
                    height: 32,
                    child: IconButton(
                      icon: Image.asset(
                        'assets/icons/chatbubble.png',
                      ),
                      onPressed: () {
                        // Navigate to CommentPageScreen with the PostModel
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                CommentPageScreen(postModel: postModel),
                          ),
                        );
                      }, //onCommentPressed(context),
                    ),
                  ),
                ],
              ),
            ),
          //Post's Release Date
          if (displayReleaseDate)
            Text(
              formattedDate,
              textAlign: TextAlign.right,
              style: const TextStyle(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //Navigate to Postpage Screen when PostWidget is clicked
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostPageScreen(postModel: postModel),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff000000)),
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //Top Container
            topCointainerWidget(true, true),
            // Middle Container
            middleContainerWidget(),
            // Bottom Container
            bottomContainerWidget(context, true, true),
          ],
        ),
      ),
    );
  }
}
