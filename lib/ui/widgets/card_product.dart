import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:test_flutter_developer_enterkomputer/data/models/models.dart';
import 'package:test_flutter_developer_enterkomputer/ui/widgets/widgets.dart';
import 'package:test_flutter_developer_enterkomputer/utils/colors.dart';
import 'package:test_flutter_developer_enterkomputer/utils/textstyles.dart';


// ignore: must_be_immutable
class CardProduct extends StatelessWidget {
  final Movie movie;
  final Function()? onTap;
  Widget? extraWidget;

  CardProduct({
    Key? key,
    required this.movie,
    this.onTap,
    this.extraWidget
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: white,
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: black.withOpacity(0.08),
                blurRadius: 5,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImageNetworkCached(
                  image: "https://image.tmdb.org/t/p/original${movie.posterPath}",
                  height: 250,),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 5),
                    Center(
                      child: Text(
                        movie.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: latoBold.copyWith(
                            fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                  
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
