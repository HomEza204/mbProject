import 'package:flutter/material.dart';
import 'package:public_toilets/screens/home/add_review.dart';
import '../../models/review.dart';

class DescriptionPage extends StatefulWidget {
  static const iconSize = 18.0;

  final String name;
  final List<Review> reviews;

  const DescriptionPage({super.key, required this.name, required this.reviews});

  @override
  State<DescriptionPage> createState() => _DescriptionPageState();
}

class _DescriptionPageState extends State<DescriptionPage> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    var colorScheme = Theme.of(context).colorScheme;
    var hreview = widget.reviews.length;
    var id;
    handleClickAdd() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => AddReviwe (toiletId: id,)));
    }

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.name),
        ),
        floatingActionButton:
            FloatingActionButton(onPressed: handleClickAdd, child: Icon(Icons.add)),
        body: Stack(
          children: [
            ListView.builder(
                itemCount: widget.reviews.length,
                itemBuilder: (ctx, i) {
                  Review review = widget.reviews![i];
                  bool hasreview = false;
                  if (review != null) {
                    hasreview = true;
                  } else {
                    hasreview = false;
                  }
                  // var hasRating = review.rating > 0;
                  var numWholeStar = review.rating.truncate();
                  var fraction = review.rating - numWholeStar;
                  var showHalfStar = fraction >= 0.5;
                  var numBlankStar = 5 - numWholeStar - (showHalfStar ? 1 : 0);
                  id = review.toiletId;
                  return hasreview
                      ? Card(
                          margin: EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 4.0),
                          child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(children: [
                                Container(
                                    width: 60.0,
                                    height: 60.0,
                                    color: colorScheme.background,
                                    child: Center(
                                        child: Icon(Icons.person, size: 30.0))),
                                SizedBox(width: 8.0),
                                Expanded(
                                    child: Text(review.review,
                                        style: textTheme.titleLarge)),
                                Column(
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Row(children: [
                                        for (var i = 0; i < review.rating; i++)
                                          Icon(Icons.star, size: DescriptionPage.iconSize),
                                        if (showHalfStar)
                                          Icon(Icons.star_half, size: DescriptionPage.iconSize),
                                        for (var i = 0; i < numBlankStar; i++)
                                          Icon(Icons.star_border,
                                              size: DescriptionPage.iconSize),
                                        //Text(toilet.averageRating.toStringAsFixed(1))
                                      ]),
                                    ])
                              ])))
                      : Center(
                          child: Text('ไม่มีความคิดเห็น'),
                        );
                })
          ],
        ));
  }
}
