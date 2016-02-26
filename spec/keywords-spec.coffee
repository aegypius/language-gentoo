# coffeelint: disable=max_line_length
# KEYWORDS="alpha amd64 arm arm64 hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~sparc-fbsd ~x86-fbsd"
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
    {tokens} = grammar.tokenizeLine "# I am a comment "
    expect(tokens).toHaveLength 1
    expect(tokens[0]).toEqual
      value: "# I am a comment "
      scopes: [
        "source.gentoo.keywords"
        "comment"
      ]

  describe "gentoo keywords syntax", ->
    it "parse keywords flags", ->
      lines = grammar.tokenizeLines """
        =dev-go/sanitized-anchor-name-0_pre20150822 ~amd64
        dev-vcs/hub amd64
        <=dev-lang/ruby-2.2.3-r2:2.2 **
      """

      expect(lines[0][0]).toEqual value: "=", scopes: ["source.gentoo.keywords", "atom", "operator"]
      expect(lines[0][1]).toEqual value: "dev-go", scopes: ["source.gentoo.keywords", "atom", "category"]
      expect(lines[0][3]).toEqual value: "sanitized-anchor-name", scopes: ["source.gentoo.keywords", "atom", "package"]
      expect(lines[0][6]).toEqual value: "0", scopes: ["source.gentoo.keywords", "atom", "version"]
      expect(lines[0][7]).toEqual value: "pre20150822", scopes: ["source.gentoo.keywords", "atom", "revision"]
      expect(lines[0][11]).toEqual value: "~amd64", scopes: ["source.gentoo.keywords", "atom", "keyword", "testing"]

      expect(lines[1][1]).toEqual value: "dev-vcs", scopes: ["source.gentoo.keywords", "atom", "category"]
      expect(lines[1][3]).toEqual value: "hub", scopes: ["source.gentoo.keywords", "atom", "package"]
      expect(lines[1][11]).toEqual value: "amd64", scopes: ["source.gentoo.keywords", "atom", "keyword", "stable"]

      expect(lines[2][0]).toEqual value: "<=", scopes: ["source.gentoo.keywords", "atom", "operator"]
      expect(lines[2][1]).toEqual value: "dev-lang", scopes: ["source.gentoo.keywords", "atom", "category"]
      expect(lines[2][3]).toEqual value: "ruby", scopes: ["source.gentoo.keywords", "atom", "package"]
      expect(lines[2][5]).toEqual value: "2.2.3", scopes: ["source.gentoo.keywords", "atom", "version"]
      expect(lines[2][7]).toEqual value: "r2", scopes: ["source.gentoo.keywords", "atom", "revision"]
      expect(lines[2][9]).toEqual value: "2.2", scopes: ["source.gentoo.keywords", "atom", "slot"]
      expect(lines[2][11]).toEqual value: "**", scopes: ["source.gentoo.keywords", "atom", "keyword", "all"]
