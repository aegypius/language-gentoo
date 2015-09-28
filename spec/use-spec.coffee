# coffeelint: disable=max_line_length

describe "use grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-gentoo").fail (reason) ->
        console.log reason

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

  describe "gentoo atom syntax", ->
    it "parse a simple gentoo atom", ->
      {tokens} = grammar.tokenizeLine "app-editors/atom"
      expect(tokens[0]).toEqual value: "app-editors", scopes: ["source.gentoo.use", "atom", "category"]
      expect(tokens[2]).toEqual value: "atom", scopes: [ "source.gentoo.use", "atom", "package"]

    it "parse a gentoo atom with version", ->
      lines = grammar.tokenizeLines """
        app-editors/atom-bin-1.0.0
        app-arch/ncompress-4.2.4.4
        sys-apps/systemd-226
        app-shells/gentoo-bashcomp-20140911
        media-gfx/pencil-0.4.4_beta
        net-analyzer/traceproto-1.1.2_beta1
        dev-util/electron-9999
        net-dns/ez-ipupdate-3.0.11.13.3_beta8-r2
      """

      expect(lines[0][0]).toEqual value: "app-editors", scopes: ["source.gentoo.use", "atom", "category"]
      expect(lines[0][2]).toEqual value: "atom-bin", scopes: ["source.gentoo.use", "atom", "package"]
      expect(lines[0][4]).toEqual value: "1.0.0", scopes: ["source.gentoo.use", "atom", "version"]

      expect(lines[1][0]).toEqual value: "app-arch", scopes: ["source.gentoo.use", "atom", "category"]
      expect(lines[1][2]).toEqual value: "ncompress", scopes: ["source.gentoo.use", "atom", "package"]
      expect(lines[1][4]).toEqual value: "4.2.4.4", scopes: ["source.gentoo.use", "atom", "version"]

      expect(lines[2][0]).toEqual value: "sys-apps", scopes: ["source.gentoo.use", "atom", "category"]
      expect(lines[2][2]).toEqual value: "systemd", scopes: ["source.gentoo.use", "atom", "package"]
      expect(lines[2][4]).toEqual value: "226", scopes: ["source.gentoo.use", "atom", "version"]

      expect(lines[3][0]).toEqual value: "app-shells", scopes: ["source.gentoo.use", "atom", "category"]
      expect(lines[3][2]).toEqual value: "gentoo-bashcomp", scopes: ["source.gentoo.use", "atom", "package"]
      expect(lines[3][4]).toEqual value: "20140911", scopes: ["source.gentoo.use", "atom", "version"]

      expect(lines[4][0]).toEqual value: "media-gfx", scopes: ["source.gentoo.use", "atom", "category"]
      expect(lines[4][2]).toEqual value: "pencil", scopes: ["source.gentoo.use", "atom", "package"]
      expect(lines[4][4]).toEqual value: "0.4.4_beta", scopes: ["source.gentoo.use", "atom", "version"]

      expect(lines[5][0]).toEqual value: "net-analyzer", scopes: ["source.gentoo.use", "atom", "category"]
      expect(lines[5][2]).toEqual value: "traceproto", scopes: ["source.gentoo.use", "atom", "package"]
      expect(lines[5][4]).toEqual value: "1.1.2_beta1", scopes: ["source.gentoo.use", "atom", "version"]

      expect(lines[6][0]).toEqual value: "dev-util", scopes: ["source.gentoo.use", "atom", "category"]
      expect(lines[6][2]).toEqual value: "electron", scopes: ["source.gentoo.use", "atom", "package"]
      expect(lines[6][4]).toEqual value: "9999", scopes: ["source.gentoo.use", "atom", "version"]

      expect(lines[7][0]).toEqual value: "net-dns", scopes: ["source.gentoo.use", "atom", "category"]
      expect(lines[7][2]).toEqual value: "ez-ipupdate", scopes: ["source.gentoo.use", "atom", "package"]
      expect(lines[7][4]).toEqual value: "3.0.11.13.3_beta8", scopes: ["source.gentoo.use", "atom", "version"]
      expect(lines[7][6]).toEqual value: "r2", scopes: ["source.gentoo.use", "atom", "revision"]

    it "parses a gentoo atom operator", ->
      lines = grammar.tokenizeLines """
        >app-editors/atom-bin-1.0.0
        <=dev-util/electron-9999
        =media-libs/mesa-10.5.1
        >=net-dns/avahi-0.6.31-r6
        >sys-libs/zlib-1.2.8-r1
      """

      expect(lines[0][0]).toEqual value: ">", scopes: ["source.gentoo.use", "atom", "operator"]
      expect(lines[0][1]).toEqual value: "app-editors", scopes: ["source.gentoo.use", "atom", "category"]
      expect(lines[0][3]).toEqual value: "atom-bin", scopes: ["source.gentoo.use", "atom", "package"]
      expect(lines[0][5]).toEqual value: "1.0.0", scopes: ["source.gentoo.use", "atom", "version"]

      expect(lines[1][0]).toEqual value: "<=", scopes: ["source.gentoo.use", "atom", "operator"]
      expect(lines[1][1]).toEqual value: "dev-util", scopes: ["source.gentoo.use", "atom", "category"]
      expect(lines[1][3]).toEqual value: "electron", scopes: ["source.gentoo.use", "atom", "package"]
      expect(lines[1][5]).toEqual value: "9999", scopes: ["source.gentoo.use", "atom", "version"]

      expect(lines[2][0]).toEqual value: "=", scopes: ["source.gentoo.use", "atom", "operator"]
      expect(lines[2][1]).toEqual value: "media-libs", scopes: ["source.gentoo.use", "atom", "category"]
      expect(lines[2][3]).toEqual value: "mesa", scopes: ["source.gentoo.use", "atom", "package"]
      expect(lines[2][5]).toEqual value: "10.5.1", scopes: ["source.gentoo.use", "atom", "version"]

      expect(lines[3][0]).toEqual value: ">=", scopes: ["source.gentoo.use", "atom", "operator"]
      expect(lines[3][1]).toEqual value: "net-dns", scopes: ["source.gentoo.use", "atom", "category"]
      expect(lines[3][3]).toEqual value: "avahi", scopes: ["source.gentoo.use", "atom", "package"]
      expect(lines[3][5]).toEqual value: "0.6.31", scopes: ["source.gentoo.use", "atom", "version"]
      expect(lines[3][7]).toEqual value: "r6", scopes: ["source.gentoo.use", "atom", "revision"]

      expect(lines[4][0]).toEqual value: ">", scopes: ["source.gentoo.use", "atom", "operator"]
      expect(lines[4][1]).toEqual value: "sys-libs", scopes: ["source.gentoo.use", "atom", "category"]
      expect(lines[4][3]).toEqual value: "zlib", scopes: ["source.gentoo.use", "atom", "package"]
      expect(lines[4][5]).toEqual value: "1.2.8", scopes: ["source.gentoo.use", "atom", "version"]
      expect(lines[4][7]).toEqual value: "r1", scopes: ["source.gentoo.use", "atom", "revision"]
