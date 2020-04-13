import 'package:flutter/material.dart';

class AdItem extends StatelessWidget {
  final int id;
  final String imagePath;
  final String title;
  final String userName;
  final String createdAt;
  final Function(int) onItemClicked;
  final bool isWishListed;
  final Function onItemDeleted;

  AdItem({
    @required this.id,
    @required this.title,
    @required this.createdAt,
    @required this.imagePath,
    @required this.userName,
    @required this.onItemClicked,
    this.isWishListed = false,
    this.onItemDeleted,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          onItemClicked(id);
        },
        child: Material(
          borderRadius: BorderRadius.circular(8.0),
          elevation: 10,
          shadowColor: Colors.grey,
          child: Stack(
            children: <Widget>[
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  imagePath,
                  fit: BoxFit.cover,
                  width: 120,
                  height: 120,
                ),
              ),
              Positioned(
                right: 0.0,
                top: 0.0,
                child: Container(
                  width: 200,
                  child: Text(
                    title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 17,
                      fontFamily: 'Cairo',
                      color: Color(0xff1f80a9),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  alignment: Alignment.topRight,
                  padding: EdgeInsets.all(8.0),
                ),
              ),
              Positioned(
                bottom: 0.0,
                right: 0.0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              userName,
                              style: TextStyle(
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                          Icon(Icons.person),
                        ],
                      ),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: Text(
                              'منذ 30 ساعة',
                              style: TextStyle(
                                fontFamily: 'Cairo',
                              ),
                            ),
                          ),
                          Icon(Icons.access_time),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              isWishListed ? GestureDetector(
                onTap: () {
                  print('Add to wishlist');
                  if (onItemDeleted != null) {
                    onItemDeleted();
                  }
                },
                child: CircleAvatar(
                  backgroundColor: Colors.black.withOpacity(0.2),
                  child: Icon(Icons.clear, color: Colors.white,),
                ),
              )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
