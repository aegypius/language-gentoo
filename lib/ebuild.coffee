{exec} = require "child_process"

module.exports =
  digest: ()->
    activeEditor = atom.workspace.getActiveEditor()

    if activeEditor
      filePath = activeEditor.getPath()
      if /\.ebuild$/.test filePath
        exec "ebuild #{filePath} digest", (err, stdout, stderr)->
          console.log   stdout if stdout
          if err
            throw new Error stderr
