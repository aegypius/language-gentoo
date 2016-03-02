# coffeelint: disable=max_line_length

describe "use grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-gentoo")

    runs ->
      grammar = atom.grammars.grammarForScopeName "source.gentoo.use"

  it "parses the grammar", ->
    useGrammar = atom.grammars.grammarForScopeName('source.gentoo.use')
    expect(useGrammar).toBeTruthy()
    expect(useGrammar.scopeName).toBe 'source.gentoo.use'

  it "parses comments", ->
    {tokens} = grammar.tokenizeLine "# I am a comment "
    expect(tokens).toHaveLength 1
    expect(tokens[0]).toEqual
      value: "# I am a comment "
      scopes: [
        "source.gentoo.use"
        "comment"
      ]

  describe "gentoo USE flags syntax", ->
    it "parse use flags", ->
      lines = grammar.tokenizeLines """
        >=dev-lang/perl-5.22.0_beta1-r6:0/5.22::gentoo berkdb -debug test
        >=media-plugins/grilo-plugins-0.2.13 upnp-av tracker
        =www-servers/nginx-1.7.6 nginx_modules_http_spdy
      """

      expect(lines[0][0]).toEqual value: ">=", scopes: ["source.gentoo.use", "atom", "operator"]
      expect(lines[0][1]).toEqual value: "dev-lang", scopes: ["source.gentoo.use", "atom", "category"]
      expect(lines[0][3]).toEqual value: "perl", scopes: ["source.gentoo.use", "atom", "package"]
      expect(lines[0][5]).toEqual value: "5.22.0_beta1", scopes: ["source.gentoo.use", "atom", "version"]
      expect(lines[0][7]).toEqual value: "r6", scopes: ["source.gentoo.use", "atom", "revision"]
      expect(lines[0][9]).toEqual value: "0/5.22", scopes: ["source.gentoo.use", "atom", "slot"]
      expect(lines[0][11]).toEqual value: "gentoo", scopes: ["source.gentoo.use", "atom", "repository"]
      expect(lines[0][13]).toEqual value: "berkdb", scopes: ["source.gentoo.use", "use-flag.add"]
      expect(lines[0][15]).toEqual value: "-debug", scopes: ["source.gentoo.use", "use-flag.remove"]
      expect(lines[0][17]).toEqual value: "test", scopes: ["source.gentoo.use", "use-flag.add"]

      expect(lines[1][0]).toEqual value: ">=", scopes: ["source.gentoo.use", "atom", "operator"]
      expect(lines[1][1]).toEqual value: "media-plugins", scopes: ["source.gentoo.use", "atom", "category"]
      expect(lines[1][3]).toEqual value: "grilo-plugins", scopes: ["source.gentoo.use", "atom", "package"]
      expect(lines[1][5]).toEqual value: "0.2.13", scopes: ["source.gentoo.use", "atom", "version"]
      expect(lines[1][7]).toEqual value: "upnp-av", scopes: ["source.gentoo.use", "use-flag.add"]
      expect(lines[1][9]).toEqual value: "tracker", scopes: ["source.gentoo.use", "use-flag.add"]

      expect(lines[2][0]).toEqual value: "=", scopes: ["source.gentoo.use", "atom", "operator"]
      expect(lines[2][1]).toEqual value: "www-servers", scopes: ["source.gentoo.use", "atom", "category"]
      expect(lines[2][3]).toEqual value: "nginx", scopes: ["source.gentoo.use", "atom", "package"]
      expect(lines[2][5]).toEqual value: "1.7.6", scopes: ["source.gentoo.use", "atom", "version"]
      expect(lines[2][7]).toEqual value: "nginx_modules_http_spdy", scopes: ["source.gentoo.use", "use-flag.add"]
