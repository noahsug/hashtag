global.main =

  run: ->
    window.addEventListener 'keydown', (e) ->
      if e.which is '51' && e.shiftKey
        @hashtagify();

  hashtagify: ->
    inputTextInfo =
      text: document.activeElement.value,
      caret: document.activeElement.selectionStart
    bounds = @getHashtagBounds(inputTextInfo)
    if bounds.start < bounds.end
      outputTextInfo = @getHashtaggedText(bounds, inputTextInfo)
      @updateDom(outputTextInfo)

  getHashtagBounds: (textInfo) ->
    bounds = {}
    preCaretText = textInfo.text.substring(0, textInfo.caret)
    postCaretText = textInfo.text.substring(textInfo.caret)

    bounds.start = 0
    bounds.end = bounds.start + preCaretText.length
    return bounds

  getHashtaggedText: (bounds, textInfo) ->
    return textInfo

  updateDom: (textInfo) ->
    setTimeout ->
      document.activeElement.value = textInfo.text
      document.activeElement.selectionStart = textInfo.caret
      document.activeElement.selectionEnd = textInfo.caret
    , 0

global.main.run();
