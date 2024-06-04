import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class HomeListSkeleton extends StatelessWidget {
  const HomeListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 4, right: 16, left: 4),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 50,
      itemBuilder: (context, index) => Card(
        color: Colors.white,
        surfaceTintColor: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        margin: const EdgeInsets.only(bottom: 16),
        child: SkeletonItem(
          child: Row(
            children: [
              const SkeletonAvatar(
                style: SkeletonAvatarStyle(
                  width: 100,
                  height: 100,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(8),
                    bottomLeft: Radius.circular(8),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 14,
                      borderRadius: BorderRadius.circular(8),
                      minLength: MediaQuery.of(context).size.width - 250,
                      maxLength: MediaQuery.of(context).size.width - 210,
                      alignment: AlignmentDirectional.topStart,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 12,
                      borderRadius: BorderRadius.circular(8),
                      minLength: 90,
                      maxLength: 140,
                      alignment: AlignmentDirectional.topStart,
                    ),
                  ),
                  const SizedBox(height: 8),
                  SkeletonLine(
                    style: SkeletonLineStyle(
                      height: 14,
                      borderRadius: BorderRadius.circular(8),
                      minLength: MediaQuery.of(context).size.width - 250,
                      maxLength: MediaQuery.of(context).size.width - 210,
                      alignment: AlignmentDirectional.topStart,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
