require '../nodejs_to_web/polyfill.coffee'
require '../coffee/main.coffee'

describe 'hashtag', ->

  beforeEach ->
    jasmine.Clock.useMock();

  it 'hashtags text', ->
    document.activeElement.value = 'sup guy?'
    document.activeElement.selectionStart = 'sup guy?'.length
    main.hashtagify()
    jasmine.Clock.tick(1);
    expect(document.activeElement.value).toBe '#supguy?'
    expect(document.activeElement.selectionStart).toBe '#supguy?'.length
    expect(document.activeElement.selectionEnd).toBe '#supguy?'.length
