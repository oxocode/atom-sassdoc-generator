SassdocGeneratorView = require './sassdoc-generator-view'
{CompositeDisposable} = require 'atom'

module.exports = SassdocGenerator =
  sassdocGeneratorView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @sassdocGeneratorView = new SassdocGeneratorView(state.sassdocGeneratorViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @sassdocGeneratorView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'sassdoc-generator:generate': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @sassdocGeneratorView.destroy()

  serialize: ->
    sassdocGeneratorViewState: @sassdocGeneratorView.serialize()

  toggle: ->
    console.log 'SassDoc created.'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
