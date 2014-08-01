module.exports =
  configDefaults:
    updateManifestOnSave: false

  activate: (state) ->
    {digest} = require "./ebuild"

    atom.workspaceView.command "ebuild:digest", -> digest()
    atom.workspaceView.command "core:save",     ->
      digest() if atom.config.get 'language-gentoo.updateManifestOnSave'

  deactivate: ->
  serialize: ->
