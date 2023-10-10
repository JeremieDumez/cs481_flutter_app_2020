import 'package:app/Networking/classes.dart';
import 'package:flutter/material.dart';

class RecapSection extends StatelessWidget {
  RecapSection({Key key, this.favoriteImages, this.postedImages})
      : super(key: key);

  final List<GalleryImage> favoriteImages;
  final List<GalleryImage> postedImages;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: DataTable(
        columns: const <DataColumn>[
          DataColumn(
            label: Text('Favorite Images')
            ),
            DataColumn(label: Text('Posted Images')
            )
      ],
      rows: [
        DataRow(
          cells: <DataCell> [
            DataCell(
              Text(favoriteImages.length.toString())
              ),
              DataCell(
                Text(postedImages.length.toString())
                )
            ]
          )
        ],
      ),
    );
  }
}
