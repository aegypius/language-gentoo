module.exports =
  config:
    updateManifestOnSave:
      type: 'boolean'
      default: false

  activate: (state) ->
    {digest} = require "./ebuild"

    atom.commands.add 'atom-text-editor',
      "ebuild:digest": -> digest()
      "core:save": ->
        digest() if atom.config.get 'language-gentoo.updateManifestOnSave'

  deactivate: ->
  serialize: ->
