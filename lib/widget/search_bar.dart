import 'package:flutter/material.dart';

enum SearchBarType {home, normal, homeLight}

class SearchBar extends StatefulWidget {

  final bool? enabled;
  final bool? hideLeft;
  final SearchBarType? searchBarType;
  final String? hint;
  final String? defaultText;
  final void Function() leftButtonClick;
  final void Function() rightButtonClick;
  final void Function() speakClick;
  final void Function() inputBoxClick;
  final ValueChanged<String> onChanged;

  const SearchBar({
    Key? key,
    this.enabled = true,
    this.hideLeft = true,
    this.searchBarType = SearchBarType.normal,
    this.hint = "",
    required this.defaultText,
    required this.leftButtonClick,
    required this.rightButtonClick,
    required this.speakClick,
    required this.inputBoxClick,
    required this.onChanged}) : super(key: key);

  @override
  _SearchBarState createState()  => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  bool showClear = false;
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    if(widget.defaultText != null && widget.defaultText != "") {
      setState((){
        _controller.text = widget.defaultText!;
      });
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return widget.searchBarType == SearchBarType.normal ? _genNormalSearch() : _genHomeSearch();
  }

  _genNormalSearch(){
    return Container(
      alignment: AlignmentDirectional.center,
      margin: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      child: Row(
        children: [
          _wrapTap(
            Container(
              child: widget.hideLeft! ? null : const Icon(Icons.arrow_back_ios, color: Colors.grey,size: 26),
            ),
            widget.leftButtonClick
          ),
          Expanded(
              flex: 1,
              child: _inputBox()
          ),
          _wrapTap(
              Container(
                padding: const EdgeInsets.only(left: 6),
                child: const Text(
                  "搜索",
                  style: TextStyle(color: Colors.blue, fontSize: 16),
                )
              ),
              widget.rightButtonClick
          ),
        ],
      ),
    );
  }
  _genHomeSearch(){
    return Container(
      alignment: AlignmentDirectional.center,
      child: Row(
        children: [
          _wrapTap(
              Container(
                margin: const EdgeInsets.only(left: 16),
                child: Row(
                  children: [
                    Text(
                      "上海",
                      style: TextStyle(color: _homeFontColor(), fontSize: 14),
                    ),
                    Icon(Icons.expand_more, color: _homeFontColor(),size: 22)
                  ],
                ),
              ),
              widget.leftButtonClick
          ),
          Expanded(
              flex: 1,
              child: _inputBox()
          ),
          _wrapTap(
              Container(
                  padding: const EdgeInsets.fromLTRB(6, 0, 16, 0),
                  margin: const EdgeInsets.only(top: 4),
                  child: Icon(Icons.comment, color: _homeFontColor(), size: 26)
              ),
              widget.rightButtonClick
          ),
        ],
      ),
    );
  }

  _homeFontColor() {
    return widget.searchBarType == SearchBarType.homeLight ? Colors.black54 : Colors.white;
  }

  _inputBox() {
    Color inputBoxColor;
    if(widget.searchBarType == SearchBarType.home) {
      inputBoxColor = Colors.white;
    } else {
      inputBoxColor = const Color(0xffEDEDED);
    }
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
      decoration: BoxDecoration(
        color: inputBoxColor,
        borderRadius: BorderRadius.circular(
          widget.searchBarType == SearchBarType.normal ? 6 : 16
        )
      ),
      child: Row(
        children: [
          Icon(
            Icons.search,
            size: 20,
            color: widget.searchBarType == SearchBarType.normal ? const Color(0xffA9A9A9) : Colors.blue,
          ),
          Expanded(
            flex: 1,
            child: widget.searchBarType == SearchBarType.normal
            ? TextField(
              controller: _controller,
              onChanged: _onTextChanged,
              autofocus: true,
              style: const TextStyle(
                fontSize:16.0,
                color: Colors.black,
                fontWeight: FontWeight.w300,
              ),
              // 输入框样式
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.fromLTRB(6, 0, 6, 0),
                isCollapsed: true,
                border: InputBorder.none,
                hintText: widget.hint,
                hintStyle: const TextStyle(fontSize: 16)
              ),
            ): _wrapTap(
            Text(
              widget.defaultText!,
              style: const TextStyle(fontSize: 16, color: Colors.grey),
            ), widget.inputBoxClick),
          ),
          !showClear ? _wrapTap(
              Icon(Icons.mic, size: 22, color: widget.searchBarType == SearchBarType.normal ? Colors.blue : Colors.grey),
            widget.speakClick
          ): _wrapTap(
              const Icon(Icons.clear, size: 22, color: Colors.grey),
              (){
                widget.onChanged("");
                setState((){
                  showClear = false;
                  _controller.clear();
                });
              })
        ],
      ),
    );
  }

  _onTextChanged(String text) {
    if(text.isNotEmpty) {
      setState((){
        showClear = true;
      });
    }else {
      setState((){
        showClear = false;
      });
    }
    widget.onChanged(text);
  }

  _wrapTap (Widget child, void Function() callback){
    return GestureDetector(
      onTap: (){
        if(callback != null){
          callback();
        }
      },
      child: child,
    );
  }
}
