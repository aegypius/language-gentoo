{exec} = require "child_process"

module.exports =
  digest: ()->
    activeEditor  = atom.workspace.getActiveTextEditor()
    notifications = atom.notifications

    if activeEditor
      filePath = activeEditor.getPath()
      if /\.ebuild$/.test filePath
        exec "ebuild #{filePath} digest", (err, stdout, stderr)->
          notifications.addError stderr, dismissable: true if err
          notifications.addSuccess "Manifest updated" unless err
