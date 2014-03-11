global.main =

  run: ->
    window.addEventListener 'keydown', (e) ->
      if e.which is 51 && e.shiftKey
        @hashtagify();

  hashtagify: ->
    inputTextInfo =
      text: document.activeElement.value,
      caret: document.activeElement.selectionStart
    bounds = @getHashtagBounds(inputTextInfo)
    if bounds.start < bounds.end
      outputTextInfo = @getHashtaggedText(inputTextInfo, bounds)
      @updateDom(outputTextInfo)

  getHashtagBounds: (textInfo) ->
    bounds = {}
    preCaretText = textInfo.text.substring(0, textInfo.caret)
    postCaretText = textInfo.text.substring(textInfo.caret)

    bounds.start = 0
    bounds.end = bounds.start + preCaretText.length
    return bounds

  getHashtaggedText: (textInfo, bounds) ->
    outputTextInfo = {}
    outputTextInfo.text = '#' + textInfo.text.replace(/\s/g, '')
    outputTextInfo.caret = bounds.start + outputTextInfo.text.length
    return outputTextInfo

  updateDom: (textInfo) ->
    setTimeout ->
      document.activeElement.value = textInfo.text
      document.activeElement.selectionStart = textInfo.caret
      document.activeElement.selectionEnd = textInfo.caret
    , 0

global.main.run();
