# coffeelint: disable=max_line_length
describe "keywords grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-gentoo")

    runs ->
      grammar = atom.grammars.grammarForScopeName "source.gentoo.keywords"

  it "parses the grammar", ->
    keywordsGrammar = atom.grammars.grammarForScopeName('source.gentoo.keywords')
    expect(keywordsGrammar).toBeTruthy()
    expect(keywordsGrammar.scopeName).toBe 'source.gentoo.keywords'

  it "parses comments", ->
    lines = grammar.tokenizeLines """
      # I am a comment
      # dev-cpp/gtkmm:3.0 ~amd64
    """
    expect(lines[0][0]).toEqual value: "# I am a comment", scopes: [ "source.gentoo.keywords", "comment" ]
    expect(lines[1][0]).toEqual value: "# dev-cpp/gtkmm:3.0 ~amd64", scopes: [ "source.gentoo.keywords", "comment" ]

  describe "gentoo keywords syntax", ->
    it "parse keywords flags", ->
      lines = grammar.tokenizeLines """
        =dev-go/sanitized-anchor-name-0_pre20150822 ~amd64
        <=dev-lang/ruby-2.2.3-r2:2.2 **
      """

      expect(lines[0][0]).toEqual value: "=", scopes: ["source.gentoo.keywords", "atom", "operator"]
      expect(lines[0][1]).toEqual value: "dev-go", scopes: ["source.gentoo.keywords", "atom", "category"]
      expect(lines[0][3]).toEqual value: "sanitized-anchor-name", scopes: ["source.gentoo.keywords", "atom", "package"]
      expect(lines[0][5]).toEqual value: "0_pre20150822", scopes: ["source.gentoo.keywords", "atom", "version"]
      expect(lines[0][7]).toEqual value: "~amd64", scopes: ["source.gentoo.keywords", "keyword", "testing"]

      expect(lines[1][0]).toEqual value: "<=", scopes: ["source.gentoo.keywords", "atom", "operator"]
      expect(lines[1][1]).toEqual value: "dev-lang", scopes: ["source.gentoo.keywords", "atom", "category"]
      expect(lines[1][3]).toEqual value: "ruby", scopes: ["source.gentoo.keywords", "atom", "package"]
      expect(lines[1][5]).toEqual value: "2.2.3", scopes: ["source.gentoo.keywords", "atom", "version"]
      expect(lines[1][7]).toEqual value: "r2", scopes: ["source.gentoo.keywords", "atom", "revision"]
      expect(lines[1][9]).toEqual value: "2.2", scopes: ["source.gentoo.keywords", "atom", "slot"]
      expect(lines[1][11]).toEqual value: "**", scopes: ["source.gentoo.keywords", "keyword", "all"]

    it "parse short syntax", ->
      lines = grammar.tokenizeLines """
        dev-vcs/hub amd64
      """
      expect(lines[0][0]).toEqual value: "dev-vcs", scopes: ["source.gentoo.keywords", "atom", "category"]
      expect(lines[0][2]).toEqual value: "hub", scopes: ["source.gentoo.keywords", "atom", "package"]
      expect(lines[0][4]).toEqual value: "amd64", scopes: ["source.gentoo.keywords", "keyword", "stable"]

    it "parse atom with repository syntax", ->
      lines = grammar.tokenizeLines """
        dev-vcs/hub::gentoo amd64
      """
      expect(lines[0][0]).toEqual value: "dev-vcs", scopes: ["source.gentoo.keywords", "atom", "category"]
      expect(lines[0][2]).toEqual value: "hub", scopes: ["source.gentoo.keywords", "atom", "package"]
      expect(lines[0][4]).toEqual value: "gentoo", scopes: ["source.gentoo.keywords", "atom", "repository"]
      expect(lines[0][6]).toEqual value: "amd64", scopes: ["source.gentoo.keywords", "keyword", "stable"]

    it "parse atom with slot syntax", ->
      lines = grammar.tokenizeLines """
        x11-base/xorg-server:0/1.16.1 ~amd64
      """
      expect(lines[0][0]).toEqual value: "x11-base", scopes: ["source.gentoo.keywords", "atom", "category"]
      expect(lines[0][2]).toEqual value: "xorg-server", scopes: ["source.gentoo.keywords", "atom", "package"]
      expect(lines[0][4]).toEqual value: "0/1.16.1", scopes: ["source.gentoo.keywords", "atom", "slot"]
      expect(lines[0][6]).toEqual value: "~amd64", scopes: ["source.gentoo.keywords", "keyword", "testing"]

    it "parse wildcard syntax", ->
      lines = grammar.tokenizeLines """
        */* ~x86
        */*::aegypius ~amd64
      """
      expect(lines[0][0]).toEqual value: "*", scopes: ["source.gentoo.keywords", "atom", "category"]
      expect(lines[0][2]).toEqual value: "*", scopes: ["source.gentoo.keywords", "atom", "package"]
      expect(lines[0][4]).toEqual value: "~x86", scopes: ["source.gentoo.keywords", "keyword", "testing"]

      expect(lines[1][0]).toEqual value: "*", scopes: ["source.gentoo.keywords", "atom", "category"]
      expect(lines[1][2]).toEqual value: "*", scopes: ["source.gentoo.keywords", "atom", "package"]
      expect(lines[1][4]).toEqual value: "aegypius", scopes: ["source.gentoo.keywords", "atom", "repository"]
      expect(lines[1][6]).toEqual value: "~amd64", scopes: ["source.gentoo.keywords", "keyword", "testing"]
