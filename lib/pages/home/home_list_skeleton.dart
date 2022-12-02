import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

class HomeListSkeleton extends StatelessWidget {
  const HomeListSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 4, right: 16, left: 2),
      physics: const AlwaysScrollableScrollPhysics(),
      itemCount: 50,
      itemBuilder: (context, index) => Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        margin: const EdgeInsets.only(bottom: 16),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: 80,
            child: SkeletonItem(
              child: Row(
                children: [
                  SkeletonAvatar(
                    style: SkeletonAvatarStyle(
                      width: 80,
                      height: 80,
                      borderRadius: BorderRadius.circular(20),
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
        ),
      ),
    );
  }
}
