import 'package:flutter/material.dart';
import 'package:skyone_mobile/util/locale_resource.dart';
import 'package:skyone_mobile/widgets/scircular_progress_indicator.dart';

class SaveButton extends StatefulWidget {
  final Function() onTap;
  final Color color;
  final bool isToggle;
  bool isSaveMode;
  final Stream<bool> progressStream;
  SaveButton({this.onTap, this.color, this.isSaveMode = true, this.isToggle = false, this.progressStream});

  @override
  _SaveButtonState createState() => _SaveButtonState();
}

class _SaveButtonState extends State<SaveButton> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        widget.onTap();
        if (widget.isToggle) {
          setState(() {
            widget.isSaveMode = !widget.isSaveMode;
          });
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(Icons.save, color: widget.color),
                StreamBuilder<bool>(
                    stream: widget.progressStream,
                    initialData: false,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data == true) {
                        return LimitedBox(maxWidth: 20, child: SCircularProgressIndicator.buildSmallest());
                      } else {
                        return const SizedBox(
                          width: 1,
                        );
                      }
                    }),
              ],
            ),
            Text(
              widget.isSaveMode ? LR.l10n('PORTAL.BUTTON.SAVE') : LR.l10n('PORTAL.BUTTON.UPDATE'),
              style: TextStyle(color: widget.color),
            )
          ],
        ),
      ),
    );
  }
}
