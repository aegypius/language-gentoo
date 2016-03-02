# coffeelint: disable=max_line_length
describe "gentoo atom grammar", ->
  grammar = null

  beforeEach ->
    waitsForPromise ->
      atom.packages.activatePackage("language-gentoo")

    runs ->
      grammar = atom.grammars.grammarForScopeName "source.gentoo"

  it "parses the grammar", ->
    useGrammar = atom.grammars.grammarForScopeName('source.gentoo')
    expect(useGrammar).toBeTruthy()
    expect(useGrammar.scopeName).toBe 'source.gentoo'

  describe "gentoo atom syntax", ->
    it "parse a simple gentoo atom", ->
      lines = grammar.tokenizeLines """
        app-editors/atom
      """
      expect(lines[0][0]).toEqual value: "app-editors", scopes: ["source.gentoo", "atom", "category"]
      expect(lines[0][2]).toEqual value: "atom", scopes: [ "source.gentoo", "atom", "package"]

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

      expect(lines[0][0]).toEqual value: "app-editors", scopes: ["source.gentoo", "atom", "category"]
      expect(lines[0][2]).toEqual value: "atom-bin", scopes: ["source.gentoo", "atom", "package"]
      expect(lines[0][4]).toEqual value: "1.0.0", scopes: ["source.gentoo", "atom", "version"]

      expect(lines[1][0]).toEqual value: "app-arch", scopes: ["source.gentoo", "atom", "category"]
      expect(lines[1][2]).toEqual value: "ncompress", scopes: ["source.gentoo", "atom", "package"]
      expect(lines[1][4]).toEqual value: "4.2.4.4", scopes: ["source.gentoo", "atom", "version"]

      expect(lines[2][0]).toEqual value: "sys-apps", scopes: ["source.gentoo", "atom", "category"]
      expect(lines[2][2]).toEqual value: "systemd", scopes: ["source.gentoo", "atom", "package"]
      expect(lines[2][4]).toEqual value: "226", scopes: ["source.gentoo", "atom", "version"]

      expect(lines[3][0]).toEqual value: "app-shells", scopes: ["source.gentoo", "atom", "category"]
      expect(lines[3][2]).toEqual value: "gentoo-bashcomp", scopes: ["source.gentoo", "atom", "package"]
      expect(lines[3][4]).toEqual value: "20140911", scopes: ["source.gentoo", "atom", "version"]

      expect(lines[4][0]).toEqual value: "media-gfx", scopes: ["source.gentoo", "atom", "category"]
      expect(lines[4][2]).toEqual value: "pencil", scopes: ["source.gentoo", "atom", "package"]
      expect(lines[4][4]).toEqual value: "0.4.4_beta", scopes: ["source.gentoo", "atom", "version"]

      expect(lines[5][0]).toEqual value: "net-analyzer", scopes: ["source.gentoo", "atom", "category"]
      expect(lines[5][2]).toEqual value: "traceproto", scopes: ["source.gentoo", "atom", "package"]
      expect(lines[5][4]).toEqual value: "1.1.2_beta1", scopes: ["source.gentoo", "atom", "version"]

      expect(lines[6][0]).toEqual value: "dev-util", scopes: ["source.gentoo", "atom", "category"]
      expect(lines[6][2]).toEqual value: "electron", scopes: ["source.gentoo", "atom", "package"]
      expect(lines[6][4]).toEqual value: "9999", scopes: ["source.gentoo", "atom", "version"]

      expect(lines[7][0]).toEqual value: "net-dns", scopes: ["source.gentoo", "atom", "category"]
      expect(lines[7][2]).toEqual value: "ez-ipupdate", scopes: ["source.gentoo", "atom", "package"]
      expect(lines[7][4]).toEqual value: "3.0.11.13.3_beta8", scopes: ["source.gentoo", "atom", "version"]
      expect(lines[7][6]).toEqual value: "r2", scopes: ["source.gentoo", "atom", "revision"]

    it "parses a gentoo atom operator", ->
      lines = grammar.tokenizeLines """
        >app-editors/atom-bin-1.0.0
        <=dev-util/electron-9999
        =media-libs/mesa-10.5.1
        >=net-dns/avahi-0.6.31-r6
        >sys-libs/zlib-1.2.8-r1
      """

      expect(lines[0][0]).toEqual value: ">", scopes: ["source.gentoo", "atom", "operator"]
      expect(lines[0][1]).toEqual value: "app-editors", scopes: ["source.gentoo", "atom", "category"]
      expect(lines[0][3]).toEqual value: "atom-bin", scopes: ["source.gentoo", "atom", "package"]
      expect(lines[0][5]).toEqual value: "1.0.0", scopes: ["source.gentoo", "atom", "version"]

      expect(lines[1][0]).toEqual value: "<=", scopes: ["source.gentoo", "atom", "operator"]
      expect(lines[1][1]).toEqual value: "dev-util", scopes: ["source.gentoo", "atom", "category"]
      expect(lines[1][3]).toEqual value: "electron", scopes: ["source.gentoo", "atom", "package"]
      expect(lines[1][5]).toEqual value: "9999", scopes: ["source.gentoo", "atom", "version"]

      expect(lines[2][0]).toEqual value: "=", scopes: ["source.gentoo", "atom", "operator"]
      expect(lines[2][1]).toEqual value: "media-libs", scopes: ["source.gentoo", "atom", "category"]
      expect(lines[2][3]).toEqual value: "mesa", scopes: ["source.gentoo", "atom", "package"]
      expect(lines[2][5]).toEqual value: "10.5.1", scopes: ["source.gentoo", "atom", "version"]

      expect(lines[3][0]).toEqual value: ">=", scopes: ["source.gentoo", "atom", "operator"]
      expect(lines[3][1]).toEqual value: "net-dns", scopes: ["source.gentoo", "atom", "category"]
      expect(lines[3][3]).toEqual value: "avahi", scopes: ["source.gentoo", "atom", "package"]
      expect(lines[3][5]).toEqual value: "0.6.31", scopes: ["source.gentoo", "atom", "version"]
      expect(lines[3][7]).toEqual value: "r6", scopes: ["source.gentoo", "atom", "revision"]

      expect(lines[4][0]).toEqual value: ">", scopes: ["source.gentoo", "atom", "operator"]
      expect(lines[4][1]).toEqual value: "sys-libs", scopes: ["source.gentoo", "atom", "category"]
      expect(lines[4][3]).toEqual value: "zlib", scopes: ["source.gentoo", "atom", "package"]
      expect(lines[4][5]).toEqual value: "1.2.8", scopes: ["source.gentoo", "atom", "version"]
      expect(lines[4][7]).toEqual value: "r1", scopes: ["source.gentoo", "atom", "revision"]

    it "parse gentoo slot", ->
      lines = grammar.tokenizeLines """
        dev-lang/python:2.7
        dev-lang/python:3.2
        dev-lang/python-3.4.3:3.4
        dev-lang/perl-5.20.2:0/5.20
        x11-base/xorg-server:0/1.16.1
      """

      expect(lines[0][0]).toEqual value: "dev-lang", scopes: ["source.gentoo", "atom", "category"]
      expect(lines[0][2]).toEqual value: "python", scopes: ["source.gentoo", "atom", "package"]
      expect(lines[0][4]).toEqual value: "2.7", scopes: ["source.gentoo", "atom", "slot"]

      expect(lines[1][0]).toEqual value: "dev-lang", scopes: ["source.gentoo", "atom", "category"]
      expect(lines[1][2]).toEqual value: "python", scopes: ["source.gentoo", "atom", "package"]
      expect(lines[1][4]).toEqual value: "3.2", scopes: ["source.gentoo", "atom", "slot"]

      expect(lines[2][0]).toEqual value: "dev-lang", scopes: ["source.gentoo", "atom", "category"]
      expect(lines[2][2]).toEqual value: "python", scopes: ["source.gentoo", "atom", "package"]
      expect(lines[2][4]).toEqual value: "3.4.3", scopes: ["source.gentoo", "atom", "version"]
      expect(lines[2][6]).toEqual value: "3.4", scopes: ["source.gentoo", "atom", "slot"]

      expect(lines[3][0]).toEqual value: "dev-lang", scopes: ["source.gentoo", "atom", "category"]
      expect(lines[3][2]).toEqual value: "perl", scopes: ["source.gentoo", "atom", "package"]
      expect(lines[3][4]).toEqual value: "5.20.2", scopes: ["source.gentoo", "atom", "version"]
      expect(lines[3][6]).toEqual value: "0/5.20", scopes: ["source.gentoo", "atom", "slot"]

      expect(lines[4][0]).toEqual value: "x11-base", scopes: ["source.gentoo", "atom", "category"]
      expect(lines[4][2]).toEqual value: "xorg-server", scopes: ["source.gentoo", "atom", "package"]
      expect(lines[4][4]).toEqual value: "0/1.16.1", scopes: ["source.gentoo", "atom", "slot"]


    it "parse gentoo repository", ->
      lines = grammar.tokenizeLines """
        app-editors/atom-bin::aegypius
        dev-lang/python::gentoo
      """

      expect(lines[0][0]).toEqual value: "app-editors", scopes: ["source.gentoo", "atom", "category"]
      expect(lines[0][2]).toEqual value: "atom-bin", scopes: ["source.gentoo", "atom", "package"]
      expect(lines[0][4]).toEqual value: "aegypius", scopes: ["source.gentoo", "atom", "repository"]

      expect(lines[1][0]).toEqual value: "dev-lang", scopes: ["source.gentoo", "atom", "category"]
      expect(lines[1][2]).toEqual value: "python", scopes: ["source.gentoo", "atom", "package"]
      expect(lines[1][4]).toEqual value: "gentoo", scopes: ["source.gentoo", "atom", "repository"]

    it "parse a full package atom", ->
      lines = grammar.tokenizeLines """
        >=dev-lang/perl-5.22.0_beta1-r6:0/5.22::gentoo
      """

      expect(lines[0][0]).toEqual value: ">=", scopes: ["source.gentoo", "atom", "operator"]
      expect(lines[0][1]).toEqual value: "dev-lang", scopes: ["source.gentoo", "atom", "category"]
      expect(lines[0][3]).toEqual value: "perl", scopes: ["source.gentoo", "atom", "package"]
      expect(lines[0][5]).toEqual value: "5.22.0_beta1", scopes: ["source.gentoo", "atom", "version"]
      expect(lines[0][7]).toEqual value: "r6", scopes: ["source.gentoo", "atom", "revision"]
      expect(lines[0][9]).toEqual value: "0/5.22", scopes: ["source.gentoo", "atom", "slot"]
      expect(lines[0][11]).toEqual value: "gentoo", scopes: ["source.gentoo", "atom", "repository"]
