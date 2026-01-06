import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class HostelCardShimmer extends StatelessWidget {
  const HostelCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: SizedBox(
          width: 190,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 130,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Text lines
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _line(width: 120),
                    const SizedBox(height: 6),
                    _line(width: 80),
                    const SizedBox(height: 10),
                    _line(width: 100),
                    const SizedBox(height: 12),

                    // Amenities pills
                    Row(
                      children: List.generate(
                        3,
                        (_) => Container(
                          margin: const EdgeInsets.only(right: 6),
                          width: 50,
                          height: 18,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(6),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _line({required double width}) {
    return Container(
      width: width,
      height: 12,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
