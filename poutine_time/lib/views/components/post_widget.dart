import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poutine_time/controller/state_manager.dart';
import 'package:poutine_time/controller/user_controller.dart';
import 'package:poutine_time/model/post_model.dart';
import 'package:poutine_time/views/commenting_page.dart';
import 'package:poutine_time/views/post_page.dart';

class PostWidget extends StatelessWidget {
  final PostModel postModel;
  bool displayUsername;
  bool displayPostOption;
  bool displayInteractions;
  bool displayReleaseDate;
  bool isTappable;

  PostWidget({
    super.key,
    required this.postModel,
    this.displayUsername = true,
    this.displayPostOption = true,
    this.displayInteractions = true,
    this.displayReleaseDate = true,
    // this variable is used to tap the post only on pages that allows it
    this.isTappable = true,
  });

  Future<void> onThumbsPressed(String fieldName) async {
    // final userID = StateManager.userController.getUserID();
    // final postCollection = StateManager.postController.postCollection;
    // final postDoc = postCollection.doc(postModel.id);

    // final hasLiked = postModel.likes.contains(userID);
    // final hasDisliked = postModel.dislikes.contains(userID);

    // if (hasLiked) {
    //   await postDoc.update({
    //     fieldName: FieldValue.arrayRemove([userID])
    //   });
    //   if (fieldName == 'likes') postModel.likes.remove(userID);
    // } else if (hasDisliked) {
    //   await postDoc.update({
    //     fieldName: FieldValue.arrayRemove([userID])
    //   });
    //   if (fieldName == 'dislikes') postModel.likes.remove(userID);
    //   return;
    // }

    // if (fieldName == 'likes')
    //   postModel.likes.add(userID);
    // else
    //   postModel.dislikes.add(userID);
    // await postDoc.update({
    //   fieldName: FieldValue.arrayUnion([userID])
    // });

    // StateManager.postController.notifyListeners();
  }

  Future<void> onThumbsUpPressed() async {
    await onThumbsPressed('likes');
  }

  Future<void> onThumbsDownPressed() async {
    await onThumbsPressed('dislikes');
  }

  Widget interactionButtonsWidget(BuildContext context) {
    return Container(
      child: Row(
        children: [
          //Thumbs Up
          InteractionButton(
            iconPath: 'assets/icons/thumbup.png',
            onPressed: onThumbsUpPressed,
            count: postModel.likes.length,
          ),
          const SizedBox(width: 4),
          // Thumbs Down
          InteractionButton(
            iconPath: 'assets/icons/thumbdown.png',
            onPressed: onThumbsDownPressed,
            count: postModel.dislikes.length,
          ),
          const SizedBox(width: 4),
          // Comment
          InteractionButton(
            iconPath: 'assets/icons/chatbubble.png',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommentPageScreen(
                    fatherPost: postModel,
                  ),
                ),
              );
            },
            count: postModel
                .comments.length, // You may replace this with the actual count
          ),
        ],
      ),
    );
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
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
                maxLines: 3, //The Maximum number of lines to display
                overflow: TextOverflow.ellipsis, //To Display (...)
              ),
            ),
          ),
          SizedBox(
              height: 10), // Adjust the spacing between description and images
          if (postModel.imageUrls.isNotEmpty)
            SizedBox(
              height: 100,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: postModel.imageUrls.length,
                itemBuilder: (context, index) {
                  var imageUrl = postModel.imageUrls[index];
                  // return Container(
                  //   margin: const EdgeInsets.only(right: 8.0),
                  //   width: 100,
                  //   height: 100,
                  //   decoration: BoxDecoration(
                  //     image: DecorationImage(
                  //       image: NetworkImage(imageUrl),
                  //       fit: BoxFit.cover,
                  //     ),
                  //     borderRadius: BorderRadius.circular(8.0),
                  //   ),
                  // );
                  Image.network(imageUrl, height: 100, width: 100);
                },
              ),
            ),
        ],
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
          if (displayInteractions) interactionButtonsWidget(context),
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
      onTap: isTappable
          ? () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostPageScreen(postModel: postModel),
                ),
              );
            }
          : null,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xff000000)),
        ),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            //Top Container
            topCointainerWidget(displayUsername, displayPostOption),
            // Middle Container
            middleContainerWidget(),
            // Bottom Container
            bottomContainerWidget(
                context, displayInteractions, displayReleaseDate),
          ],
        ),
      ),
    );
  }
}

class InteractionButton extends StatelessWidget {
  const InteractionButton({
    Key? key,
    required this.iconPath,
    required this.onPressed,
    required this.count,
  }) : super(key: key);

  final String iconPath;
  final VoidCallback onPressed;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        SizedBox(
          width: 32,
          height: 32,
          child: IconButton(
            icon: Image.asset(iconPath),
            onPressed: onPressed,
          ),
        ),
        if (count > 0) ...[
          const SizedBox(
            width: 4,
          ),
          SizedBox(
            width: 16,
            height: 16,
            child: Text(
              count.toString(),
              style: const TextStyle(
                color: Color(0xff000000),
              ),
            ),
          )
        ]
      ],
    );
  }
}
