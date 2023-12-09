import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchAndFilterWidget extends StatelessWidget {
  const SearchAndFilterWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            height: 60,
            child: TextFormField(
              decoration: InputDecoration(
                  hintText: "Search Audiobooks",
                  prefixIcon: const Icon(CupertinoIcons.search),
                  suffixIcon: const Icon(CupertinoIcons.mic_fill),
                  fillColor: Colors.black12.withOpacity(0.1),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  enabledBorder: UnderlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.transparent,
                      ),
                      borderRadius: BorderRadius.circular(12)),
                  filled: true),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(14),
            margin: const EdgeInsets.only(left: 10, bottom: 12),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(12)),
            child: const Icon(
              Icons.filter_alt,
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
