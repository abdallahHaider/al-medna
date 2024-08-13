import 'package:admin/controllers/general_information.dart';
import 'package:admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../utl/constants.dart';
import '../../widgets/erorr_widget.dart';
import 'file_info_card.dart';

class MyFiles extends StatelessWidget {
  const MyFiles({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "الاحصائيات العامة",
              style: Theme.of(context).textTheme.titleMedium,
            ),

          ],
        ),
        SizedBox(height: defaultPadding),

    Consumer<GeneralInformationController>(builder: (e, a, s) {
            return FutureBuilder(
                future: a.fetchData(),
                builder: (gg, bb) {
                  if (bb.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (bb.hasError) {
                    return ErorrWidget();
                  } else  {
                    return   Responsive(
          mobile: FileInfoCardGridView(
            crossAxisCount: _size.width < 650 ? 2 : 4,
            childAspectRatio: _size.width < 650 && _size.width > 350 ? 1.3 : 1,
           demo:  bb.data!
          ),
          tablet: FileInfoCardGridView(           demo:  bb.data!
),
          desktop: FileInfoCardGridView(
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,           demo:  bb.data!

          ),
        );
                  }
                });
          }),

      
      ],
    );
  }
}

class FileInfoCardGridView extends StatelessWidget {
  const FileInfoCardGridView({
    required this.demo,
    Key? key,
    this.crossAxisCount = 4,
    this.childAspectRatio = 1,
  }) : super(key: key);

  final int crossAxisCount;
  final double childAspectRatio;
  final List demo;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: demo.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: defaultPadding,
        mainAxisSpacing: defaultPadding,
        childAspectRatio: childAspectRatio,
      ),
      itemBuilder: (context, index) => FileInfoCard(info: demo[index]),
    );
  }
}
