import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poutine_time/controller/state_manager.dart';
import 'package:poutine_time/controller/user_controller.dart';
import 'package:poutine_time/model/post_model.dart';
import 'package:poutine_time/views/commenting_page.dart';
import 'package:poutine_time/views/post_page.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../controller/post_controller.dart';

// For real time update for likes and dislikes we need a statefulWidget
class PostWidget extends StatefulWidget {
  final PostModel postModel;
  bool displayUsername;
  bool displayPostOption;
  bool displayInteractions;
  bool displayReleaseDate;
  bool isTappable;

  PostWidget({
    Key? key,
    required this.postModel,
    this.displayUsername = true,
    this.displayPostOption = true,
    this.displayInteractions = true,
    this.displayReleaseDate = true,
    this.isTappable = true,
  }) : super(key: key);

  @override

  _PostWidgetState createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  late PostModel _postModel;
  PageController _pageController = PageController();

  Color maroonColor = const Color(0xFF800000);
  Color darkTextColor = const Color(0xFF212121);

  @override
  void initState() {
    super.initState();
    _postModel = widget.postModel;
  }

  // Widget to build the image and slide images
  Widget buildImageSection() {
    if (_postModel.imageUrls != null && _postModel.imageUrls.isNotEmpty) {
      return Column(
        children: [
          // Specifying a definite height for the PageView
          Container(
            height: 200, // Adjust the height as needed
            child: PageView.builder(
              controller: _pageController,
              itemCount: _postModel.imageUrls.length,
              itemBuilder: (context, index) {
                return Image.network(_postModel.imageUrls[index]);
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                onPressed: () {
                  if (_pageController.hasClients && _pageController.page! > 0) {
                    _pageController.previousPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  if (_pageController.hasClients && _pageController.page! < _postModel.imageUrls.length - 1) {
                    _pageController.nextPage(duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
                  }
                },
              ),
            ],
          ),
        ],
      );
    } else {

      // Shrinking to adjust size
      return SizedBox.shrink();
    }
  }


  void onThumbsUpPressed() async {
    if (_postModel.id == null) {
      print('Error: Post ID is null');
      return;
    }
    String postId = _postModel.id!;

    UserController userController = UserController();
    userController.setUser();
    if (userController.getUserID() == null) {
      print('Error: User ID is null');
      return;
    }
    String userId = userController.getUserID();

    // Call the likepost method from controller to update the likes
    await PostControllerService().likePost(postId, userId);

    setState(() {
      // Add to likes and remove from dislikes
      if (!_postModel.likes.contains(userId)) {
        _postModel.likes.add(userId);
      }
      if (_postModel.dislikes.contains(userId)) {
        _postModel.dislikes.remove(userId);
      }
    });
  }

  void onThumbsDownPressed() async {
    if (_postModel.id == null) {
      print('Error: Post ID is null');
      return;
    }
    String postId = _postModel.id!;

    UserController userController = UserController();
    userController.setUser();
    if (userController.getUserID() == null) {
      print('Error: User ID is null');
      return;
    }
    String userId = userController.getUserID();

    await PostControllerService().dislikePost(postId, userId);

    setState(() {
      // Add to dislikes and remove from likes
      if (!_postModel.dislikes.contains(userId)) {
        _postModel.dislikes.add(userId);
      }
      if (_postModel.likes.contains(userId)) {
        _postModel.likes.remove(userId);
      }
    });
  }

  Widget interactionButtonsWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        InteractionButton(
          iconData: Icons.thumb_up,
          onPressed: onThumbsUpPressed,
          count: _postModel.likes.length,
          iconColor: maroonColor,
          textColor: darkTextColor,
        ),
        InteractionButton(
          iconData: Icons.thumb_down,
          onPressed: onThumbsDownPressed,
          count: _postModel.dislikes.length,
          iconColor: maroonColor,
          textColor: darkTextColor,
        ),
        InteractionButton(
          iconData: Icons.comment,
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CommentPageScreen(fatherPost: _postModel),
              ),
            );
          },
          count: _postModel.comments.length,
          iconColor: maroonColor,
          textColor: darkTextColor,
        ),
      ],
    );
  }


  Widget topContainerWidget(bool displayUsername, bool displayPostOption) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (displayUsername)
            Text(
              _postModel.username,
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                letterSpacing: 1.0,
                color: Colors.red[800],
              ),
            ),
          if (displayPostOption)
            IconButton(
              icon: Icon(Icons.more_vert, color: Colors.red[800]),
              onPressed: () {},
            ),
        ],
      ),
    );
  }

  Widget middleContainerWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Text(
        _postModel.description,
        style: GoogleFonts.lato(
          fontSize: 15,
          fontWeight: FontWeight.w400,
          color: Colors.black87,
        ),
        maxLines: 3,
        overflow: TextOverflow.ellipsis,
      ),
    );
  }


  Widget bottomContainerWidget(BuildContext context, bool displayInteractions,
      bool displayReleaseDate) {
    String formattedDate = DateFormat('dd-MM-yyyy').format(
        _postModel.release_date);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          if (displayInteractions) Expanded(
              child: interactionButtonsWidget(context)),
          if (displayReleaseDate)
            Text(
              formattedDate,
              style: GoogleFonts.lato(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black87,
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isTappable ? () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PostPageScreen(postModel: _postModel),
          ),
        );
      } : null,
      child: Card(
        margin: const EdgeInsets.all(8.0),
        elevation: 4.0,
        shadowColor: Colors.red[800]?.withOpacity(0.5),
        color: Colors.grey[100],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            // Top container widget (username and post option)
            topContainerWidget(widget.displayUsername, widget.displayPostOption),
            // Middle container widget (post description)
            middleContainerWidget(),
            // Image section
            buildImageSection(),
            // Bottom container widget (interactions and release date)
            bottomContainerWidget(context, widget.displayInteractions, widget.displayReleaseDate),
          ],
        ),
      ),
    );
  }
}

class InteractionButton extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;
  final int count;
  final Color iconColor;
  final Color textColor;

  InteractionButton({
    Key? key,
    required this.iconData,
    required this.onPressed,
    required this.count,
    required this.iconColor,
    required this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        IconButton(
          icon: Icon(iconData, color: iconColor),
          onPressed: onPressed,
          iconSize: 24,
        ),
        if (count > 0)
          Text(
            count.toString(),
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        SizedBox(width: 8),
      ],
    );
  }
}