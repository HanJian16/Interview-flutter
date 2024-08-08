import 'package:flutter/material.dart';
import 'package:interview_flutter/components/custom_dropdown_dialog.dart';
import 'package:interview_flutter/components/list_content_widget.dart';
import 'package:interview_flutter/components/not_found_widget.dart';
import 'package:interview_flutter/providers/list_provider.dart';
import 'package:provider/provider.dart';

class BodyContent extends StatelessWidget {
  const BodyContent({
    super.key,
    required this.idx,
  });

  final int idx;

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<ListProvider>();

    return Stack(
      children: [
        if (idx == 2 && chatProvider.list.isNotEmpty)
          const ListContent()
        else
          const NotFoundWidget(),
        if (idx == 2)
          Positioned(
            bottom: 30,
            right: 20,
            child: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  builder: (context) => const CustomDropDownDialog(),
                );
              },
              backgroundColor: Colors.blue,
              child: const Icon(Icons.add, color: Colors.white),
            ),
          ),
      ],
    );
  }
}


