# coffeelint: disable=max_line_length

describe "use ebuild grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-gentoo")

    runs ->
      grammar = atom.grammars.grammarForScopeName "source.shell.ebuild"

  it "parses the grammar", ->
    useGrammar = atom.grammars.grammarForScopeName('source.shell.ebuild')
    expect(useGrammar).toBeTruthy()
    expect(useGrammar.scopeName).toBe 'source.shell.ebuild'

  it "parses eclass inherits", ->
    {tokens} = grammar.tokenizeLine "inherit flag-o-matic python-any-r1 eutils unpacker pax-utils"
    console.log(tokens)
    expect(tokens).toHaveLength 11
    expect(tokens[0]).toEqual
      value: "inherit"
      scopes: [
        "source.shell.ebuild",
        "storage.modifier.shell"
      ]

    [1, 3, 5, 7, 9].forEach (i) -> expect(tokens[i]).toEqual
      value: " "
      scopes: [
        "source.shell.ebuild",
      ]
    expect(tokens[2]).toEqual value: "flag-o-matic", scopes: [
        "source.shell.ebuild",
        "entity.name.type.object.eclass",
      ]
    expect(tokens[4]).toEqual value: "python-any-r1", scopes: [
        "source.shell.ebuild",
        "entity.name.type.object.eclass",
      ]
    expect(tokens[6]).toEqual value: "eutils", scopes: [
        "source.shell.ebuild",
        "entity.name.type.object.eclass",
      ]
    expect(tokens[8]).toEqual value: "unpacker", scopes: [
        "source.shell.ebuild",
        "entity.name.type.object.eclass",
      ]
    expect(tokens[10]).toEqual value: "pax-utils", scopes: [
        "source.shell.ebuild",
        "entity.name.type.object.eclass",
      ]
