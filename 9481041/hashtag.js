var main = {
  run: function() {
    return window.addEventListener('keydown', function(e) {
      if (e.which === 51 && e.shiftKey) {
        return main.hashtagify();
      }
    });
  },
  hashtagify: function() {
    var bounds, inputTextInfo, outputTextInfo;
    inputTextInfo = {
      text: document.activeElement.value,
      caret: document.activeElement.selectionEnd
    };
    bounds = main.getHashtagBounds(inputTextInfo);
    if (bounds.start < bounds.end) {
      outputTextInfo = main.getHashtaggedText(inputTextInfo, bounds);
      return main.updateDom(outputTextInfo);
    }
  },
  getHashtagBounds: function(textInfo) {
    var lastHashtagDistance, preCaretText, singleLine, split;
    preCaretText = textInfo.text.substring(0, textInfo.caret);
    if (/\s$/.test(preCaretText)) {
      return {};
    }
    singleLine = (split = preCaretText.split('\n'))[split.length - 1];
    lastHashtagDistance = main.reverseStr(singleLine).search(/\s*\S+#(\s|$)/);
    if (lastHashtagDistance === -1) {
      lastHashtagDistance = singleLine.length;
    }
    return {
      start: preCaretText.length - lastHashtagDistance,
      end: preCaretText.length
    };
  },
  getHashtaggedText: function(textInfo, bounds) {
    var hashtag, output, textToHashtag;
    textToHashtag = textInfo.text.substring(bounds.start, bounds.end);
    hashtag = main.formHashtag(textToHashtag);
    output = main.spliceStr(textInfo.text, bounds.start, bounds.end, hashtag);
    return {
      text: output,
      caret: bounds.start + hashtag.length
    };
  },
  formHashtag: function(text) {
    text = text.replace(/[\s,#;:'"]/g, '');
    text = text.replace(/[.?!](?!$)/g, '');
    text = text.toLowerCase();
    return text = '#' + text;
  },
  updateDom: function(textInfo) {
    return setTimeout(function() {
      document.activeElement.value = textInfo.text;
      document.activeElement.selectionStart = textInfo.caret;
      return document.activeElement.selectionEnd = textInfo.caret;
    }, 0);
  },
  spliceStr: function(str, start, end, add) {
    return str.slice(0, start) + add + str.slice(end);
  },
  reverseStr: function(str) {
    return str.split('').reverse().join('');
  }
};

main.run();
