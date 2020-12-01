part of judo.components;

class JudoContainer extends StatefulWidget {

  JudoContainer({
    Key key,
    this.child,
    this.col = 4,
    this.row = 1,
    this.padding,
    this.color,
    this.stretch = false,
    this.alignment,
  }) : super(key: key);

  final Widget child;
  final EdgeInsets padding;
  final int col;
  final int row;
  final Color color;
  final bool stretch;
  final Alignment alignment;

  @override
  _JudoContainerState createState() => _JudoContainerState();
}

class _JudoContainerState extends State<JudoContainer> {

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: widget.col,
      child: Container(
        color: widget.color,
        height: widget.row * JudoComponentsSettings.height,
        padding: widget.padding,
        child: Align(
          alignment: widget.alignment,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                fit: widget.stretch ? FlexFit.tight : FlexFit.loose,
                child: widget.child
              ),
            ],
          ),
        ),
      ),
    );
  }
}
