require './nodejs_to_web.coffee'
require '../coffee/main.coffee'

describe 'hashtag', ->

  it 'hashtags text', ->
    document.activeElement.value = 'sup guy?'
    document.activeElement.selectionStart = 'sup guy?'.length
    main.hashtagify()
    runs ->
      expect(document.activeElement.value).toBe 'sup guy?'
      expect(document.activeElement.selectionStart).toBe 'sup guy?'.length
      expect(document.activeElement.selectionEnd).toBe 'sup guy?'.length
