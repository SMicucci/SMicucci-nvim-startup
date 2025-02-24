local data = {
  lspconfig_to_mason = {
    angularls = "angular-language-server",
    ansiblels = "ansible-language-server",
    antlersls = "antlers-language-server",
    apex_ls = "apex-language-server",
    arduino_language_server = "arduino-language-server",
    asm_lsp = "asm-lsp",
    ast_grep = "ast-grep",
    astro = "astro-language-server",
    autotools_ls = "autotools-language-server",
    awk_ls = "awk-language-server",
    azure_pipelines_ls = "azure-pipelines-language-server",
    basedpyright = "basedpyright",
    bashls = "bash-language-server",
    beancount = "beancount-language-server",
    bicep = "bicep-lsp",
    biome = "biome",
    bright_script = "brighterscript",
    bsl_ls = "bsl-language-server",
    buf_ls = "buf",
    bzl = "bzl",
    cairo_ls = "cairo-language-server",
    clangd = "clangd",
    clarity_lsp = "clarity-lsp",
    clojure_lsp = "clojure-lsp",
    cmake = "cmake-language-server",
    cobol_ls = "cobol-language-support",
    codeqlls = "codeql",
    coq_lsp = "coq-lsp",
    crystalline = "crystalline",
    csharp_ls = "csharp-language-server",
    css_variables = "css-variables-language-server",
    cssls = "css-lsp",
    cssmodules_ls = "cssmodules-language-server",
    cucumber_language_server = "cucumber-language-server",
    custom_elements_ls = "custom-elements-languageserver",
    cypher_ls = "cypher-language-server",
    dagger = "cuelsp",
    denols = "deno",
    dhall_lsp_server = "dhall-lsp",
    diagnosticls = "diagnostic-languageserver",
    docker_compose_language_service = "docker-compose-language-service",
    dockerls = "dockerfile-language-server",
    dotls = "dot-language-server",
    dprint = "dprint",
    drools_lsp = "drools-lsp",
    earthlyls = "earthlyls",
    efm = "efm",
    elixirls = "elixir-ls",
    elmls = "elm-language-server",
    elp = "elp",
    ember = "ember-language-server",
    emmet_language_server = "emmet-language-server",
    emmet_ls = "emmet-ls",
    erg_language_server = "erg-language-server",
    erlangls = "erlang-ls",
    esbonio = "esbonio",
    eslint = "eslint-lsp",
    facility_language_server = "facility-language-server",
    fennel_language_server = "fennel-language-server",
    fennel_ls = "fennel-ls",
    flux_lsp = "flux-lsp",
    foam_ls = "foam-language-server",
    fortls = "fortls",
    fsautocomplete = "fsautocomplete",
    ginko_ls = "ginko_ls",
    gitlab_ci_ls = "gitlab-ci-ls",
    glint = "glint",
    glsl_analyzer = "glsl_analyzer",
    glslls = "glslls",
    golangci_lint_ls = "golangci-lint-langserver",
    gopls = "gopls",
    gradle_ls = "gradle-language-server",
    grammarly = "grammarly-languageserver",
    graphql = "graphql-language-service-cli",
    groovyls = "groovy-language-server",
    harper_ls = "harper-ls",
    haxe_language_server = "haxe-language-server",
    hdl_checker = "hdl-checker",
    helm_ls = "helm-ls",
    hls = "haskell-language-server",
    hoon_ls = "hoon-language-server",
    html = "html-lsp",
    htmx = "htmx-lsp",
    hydra_lsp = "hydra-lsp",
    hyprls = "hyprls",
    intelephense = "intelephense",
    java_language_server = "java-language-server",
    jdtls = "jdtls",
    jedi_language_server = "jedi-language-server",
    jinja_lsp = "jinja-lsp",
    jqls = "jq-lsp",
    jsonls = "json-lsp",
    jsonnet_ls = "jsonnet-language-server",
    julials = "julia-lsp",
    kcl = "kcl",
    kotlin_language_server = "kotlin-language-server",
    lelwel_ls = "lelwel",
    lemminx = "lemminx",
    lexical = "lexical",
    ltex = "ltex-ls",
    lua_ls = "lua-language-server",
    luau_lsp = "luau-lsp",
    lwc_ls = "lwc-language-server",
    markdown_oxide = "markdown-oxide",
    marksman = "marksman",
    matlab_ls = "matlab-language-server",
    mdx_analyzer = "mdx-analyzer",
    mesonlsp = "mesonlsp",
    millet = "millet",
    mm0_ls = "metamath-zero-lsp",
    motoko_lsp = "motoko-lsp",
    move_analyzer = "move-analyzer",
    mutt_ls = "mutt-language-server",
    neocmake = "neocmakelsp",
    nextls = "nextls",
    nginx_language_server = "nginx-language-server",
    nickel_ls = "nickel-lang-lsp",
    nil_ls = "nil",
    nim_langserver = "nimlangserver",
    nimls = "nimlsp",
    ocamllsp = "ocaml-lsp",
    ols = "ols",
    omnisharp = "omnisharp",
    omnisharp_mono = "omnisharp-mono",
    opencl_ls = "opencl-language-server",
    openscad_lsp = "openscad-lsp",
    pbls = "pbls",
    perlnavigator = "perlnavigator",
    pest_ls = "pest-language-server",
    phpactor = "phpactor",
    pico8_ls = "pico8-ls",
    pkgbuild_language_server = "pkgbuild-language-server",
    powershell_es = "powershell-editor-services",
    prismals = "prisma-language-server",
    prosemd_lsp = "prosemd-lsp",
    psalm = "psalm",
    puppet = "puppet-editor-services",
    purescriptls = "purescript-language-server",
    pylsp = "python-lsp-server",
    pylyzer = "pylyzer",
    pyre = "pyre",
    pyright = "pyright",
    quick_lint_js = "quick-lint-js",
    r_language_server = "r-languageserver",
    raku_navigator = "raku-navigator",
    reason_ls = "reason-language-server",
    regal = "regal",
    regols = "regols",
    remark_ls = "remark-language-server",
    rescriptls = "rescript-language-server",
    rnix = "rnix-lsp",
    robotframework_ls = "robotframework-lsp",
    rome = "rome",
    rubocop = "rubocop",
    ruby_lsp = "ruby-lsp",
    ruff = "ruff",
    rust_analyzer = "rust-analyzer",
    salt_ls = "salt-lsp",
    serve_d = "serve-d",
    shopify_theme_ls = "shopify-cli",
    slint_lsp = "slint-lsp",
    smithy_ls = "smithy-language-server",
    snakeskin_ls = "snakeskin-cli",
    snyk_ls = "snyk-ls",
    solang = "solang",
    solargraph = "solargraph",
    solc = "solidity",
    solidity = "solidity-ls",
    solidity_ls = "vscode-solidity-server",
    solidity_ls_nomicfoundation = "nomicfoundation-solidity-language-server",
    somesass_ls = "some-sass-language-server",
    sorbet = "sorbet",
    sourcery = "sourcery",
    spectral = "spectral-language-server",
    sqlls = "sqlls",
    sqls = "sqls",
    standardrb = "standardrb",
    starlark_rust = "starlark-rust",
    starpls = "starpls",
    steep = "steep",
    stimulus_ls = "stimulus-language-server",
    stylelint_lsp = "stylelint-lsp",
    svelte = "svelte-language-server",
    svlangserver = "svlangserver",
    svls = "svls",
    swift_mesonls = "swift-mesonlsp",
    tailwindcss = "tailwindcss-language-server",
    taplo = "taplo",
    teal_ls = "teal-language-server",
    templ = "templ",
    terraformls = "terraform-ls",
    texlab = "texlab",
    textlsp = "textlsp",
    tflint = "tflint",
    theme_check = "shopify-theme-check",
    thriftls = "thriftls",
    tinymist = "tinymist",
    ts_ls = "typescript-language-server",
    tsp_server = "tsp-server",
    twiggy_language_server = "twiggy-language-server",
    typos_lsp = "typos-lsp",
    unocss = "unocss-language-server",
    v_analyzer = "v-analyzer",
    vacuum = "vacuum",
    vala_ls = "vala-language-server",
    vale_ls = "vale-ls",
    verible = "verible",
    veryl_ls = "veryl-ls",
    vhdl_ls = "rust_hdl",
    vimls = "vim-language-server",
    visualforce_ls = "visualforce-language-server",
    vls = "vls",
    volar = "vue-language-server",
    vtsls = "vtsls",
    vuels = "vetur-vls",
    wgsl_analyzer = "wgsl-analyzer",
    yamlls = "yaml-language-server",
    zk = "zk",
    zls = "zls"
  },
  mason_to_lspconfig = {
    ["angular-language-server"] = "angularls",
    ["ansible-language-server"] = "ansiblels",
    ["antlers-language-server"] = "antlersls",
    ["apex-language-server"] = "apex_ls",
    ["arduino-language-server"] = "arduino_language_server",
    ["asm-lsp"] = "asm_lsp",
    ["ast-grep"] = "ast_grep",
    ["astro-language-server"] = "astro",
    ["autotools-language-server"] = "autotools_ls",
    ["awk-language-server"] = "awk_ls",
    ["azure-pipelines-language-server"] = "azure_pipelines_ls",
    basedpyright = "basedpyright",
    ["bash-language-server"] = "bashls",
    ["beancount-language-server"] = "beancount",
    ["bicep-lsp"] = "bicep",
    biome = "biome",
    brighterscript = "bright_script",
    ["bsl-language-server"] = "bsl_ls",
    buf = "buf_ls",
    bzl = "bzl",
    ["cairo-language-server"] = "cairo_ls",
    clangd = "clangd",
    ["clarity-lsp"] = "clarity_lsp",
    ["clojure-lsp"] = "clojure_lsp",
    ["cmake-language-server"] = "cmake",
    ["cobol-language-support"] = "cobol_ls",
    codeql = "codeqlls",
    ["coq-lsp"] = "coq_lsp",
    crystalline = "crystalline",
    ["csharp-language-server"] = "csharp_ls",
    ["css-lsp"] = "cssls",
    ["css-variables-language-server"] = "css_variables",
    ["cssmodules-language-server"] = "cssmodules_ls",
    ["cucumber-language-server"] = "cucumber_language_server",
    cuelsp = "dagger",
    ["custom-elements-languageserver"] = "custom_elements_ls",
    ["cypher-language-server"] = "cypher_ls",
    deno = "denols",
    ["dhall-lsp"] = "dhall_lsp_server",
    ["diagnostic-languageserver"] = "diagnosticls",
    ["docker-compose-language-service"] = "docker_compose_language_service",
    ["dockerfile-language-server"] = "dockerls",
    ["dot-language-server"] = "dotls",
    dprint = "dprint",
    ["drools-lsp"] = "drools_lsp",
    earthlyls = "earthlyls",
    efm = "efm",
    ["elixir-ls"] = "elixirls",
    ["elm-language-server"] = "elmls",
    elp = "elp",
    ["ember-language-server"] = "ember",
    ["emmet-language-server"] = "emmet_language_server",
    ["emmet-ls"] = "emmet_ls",
    ["erg-language-server"] = "erg_language_server",
    ["erlang-ls"] = "erlangls",
    esbonio = "esbonio",
    ["eslint-lsp"] = "eslint",
    ["facility-language-server"] = "facility_language_server",
    ["fennel-language-server"] = "fennel_language_server",
    ["fennel-ls"] = "fennel_ls",
    ["flux-lsp"] = "flux_lsp",
    ["foam-language-server"] = "foam_ls",
    fortls = "fortls",
    fsautocomplete = "fsautocomplete",
    ginko_ls = "ginko_ls",
    ["gitlab-ci-ls"] = "gitlab_ci_ls",
    glint = "glint",
    glsl_analyzer = "glsl_analyzer",
    glslls = "glslls",
    ["golangci-lint-langserver"] = "golangci_lint_ls",
    gopls = "gopls",
    ["gradle-language-server"] = "gradle_ls",
    ["grammarly-languageserver"] = "grammarly",
    ["graphql-language-service-cli"] = "graphql",
    ["groovy-language-server"] = "groovyls",
    ["harper-ls"] = "harper_ls",
    ["haskell-language-server"] = "hls",
    ["haxe-language-server"] = "haxe_language_server",
    ["hdl-checker"] = "hdl_checker",
    ["helm-ls"] = "helm_ls",
    ["hoon-language-server"] = "hoon_ls",
    ["html-lsp"] = "html",
    ["htmx-lsp"] = "htmx",
    ["hydra-lsp"] = "hydra_lsp",
    hyprls = "hyprls",
    intelephense = "intelephense",
    ["java-language-server"] = "java_language_server",
    jdtls = "jdtls",
    ["jedi-language-server"] = "jedi_language_server",
    ["jinja-lsp"] = "jinja_lsp",
    ["jq-lsp"] = "jqls",
    ["json-lsp"] = "jsonls",
    ["jsonnet-language-server"] = "jsonnet_ls",
    ["julia-lsp"] = "julials",
    kcl = "kcl",
    ["kotlin-language-server"] = "kotlin_language_server",
    lelwel = "lelwel_ls",
    lemminx = "lemminx",
    lexical = "lexical",
    ["ltex-ls"] = "ltex",
    ["lua-language-server"] = "lua_ls",
    ["luau-lsp"] = "luau_lsp",
    ["lwc-language-server"] = "lwc_ls",
    ["markdown-oxide"] = "markdown_oxide",
    marksman = "marksman",
    ["matlab-language-server"] = "matlab_ls",
    ["mdx-analyzer"] = "mdx_analyzer",
    mesonlsp = "mesonlsp",
    ["metamath-zero-lsp"] = "mm0_ls",
    millet = "millet",
    ["motoko-lsp"] = "motoko_lsp",
    ["move-analyzer"] = "move_analyzer",
    ["mutt-language-server"] = "mutt_ls",
    neocmakelsp = "neocmake",
    nextls = "nextls",
    ["nginx-language-server"] = "nginx_language_server",
    ["nickel-lang-lsp"] = "nickel_ls",
    ["nil"] = "nil_ls",
    nimlangserver = "nim_langserver",
    nimlsp = "nimls",
    ["nomicfoundation-solidity-language-server"] = "solidity_ls_nomicfoundation",
    ["ocaml-lsp"] = "ocamllsp",
    ols = "ols",
    omnisharp = "omnisharp",
    ["omnisharp-mono"] = "omnisharp_mono",
    ["opencl-language-server"] = "opencl_ls",
    ["openscad-lsp"] = "openscad_lsp",
    pbls = "pbls",
    perlnavigator = "perlnavigator",
    ["pest-language-server"] = "pest_ls",
    phpactor = "phpactor",
    ["pico8-ls"] = "pico8_ls",
    ["pkgbuild-language-server"] = "pkgbuild_language_server",
    ["powershell-editor-services"] = "powershell_es",
    ["prisma-language-server"] = "prismals",
    ["prosemd-lsp"] = "prosemd_lsp",
    psalm = "psalm",
    ["puppet-editor-services"] = "puppet",
    ["purescript-language-server"] = "purescriptls",
    pylyzer = "pylyzer",
    pyre = "pyre",
    pyright = "pyright",
    ["python-lsp-server"] = "pylsp",
    ["quick-lint-js"] = "quick_lint_js",
    ["r-languageserver"] = "r_language_server",
    ["raku-navigator"] = "raku_navigator",
    ["reason-language-server"] = "reason_ls",
    regal = "regal",
    regols = "regols",
    ["remark-language-server"] = "remark_ls",
    ["rescript-language-server"] = "rescriptls",
    ["rnix-lsp"] = "rnix",
    ["robotframework-lsp"] = "robotframework_ls",
    rome = "rome",
    rubocop = "rubocop",
    ["ruby-lsp"] = "ruby_lsp",
    ruff = "ruff",
    ["rust-analyzer"] = "rust_analyzer",
    rust_hdl = "vhdl_ls",
    ["salt-lsp"] = "salt_ls",
    ["serve-d"] = "serve_d",
    ["shopify-cli"] = "shopify_theme_ls",
    ["shopify-theme-check"] = "theme_check",
    ["slint-lsp"] = "slint_lsp",
    ["smithy-language-server"] = "smithy_ls",
    ["snakeskin-cli"] = "snakeskin_ls",
    ["snyk-ls"] = "snyk_ls",
    solang = "solang",
    solargraph = "solargraph",
    solidity = "solc",
    ["solidity-ls"] = "solidity",
    ["some-sass-language-server"] = "somesass_ls",
    sorbet = "sorbet",
    sourcery = "sourcery",
    ["spectral-language-server"] = "spectral",
    sqlls = "sqlls",
    sqls = "sqls",
    standardrb = "standardrb",
    ["starlark-rust"] = "starlark_rust",
    starpls = "starpls",
    steep = "steep",
    ["stimulus-language-server"] = "stimulus_ls",
    ["stylelint-lsp"] = "stylelint_lsp",
    ["svelte-language-server"] = "svelte",
    svlangserver = "svlangserver",
    svls = "svls",
    ["swift-mesonlsp"] = "swift_mesonls",
    ["tailwindcss-language-server"] = "tailwindcss",
    taplo = "taplo",
    ["teal-language-server"] = "teal_ls",
    templ = "templ",
    ["terraform-ls"] = "terraformls",
    texlab = "texlab",
    textlsp = "textlsp",
    tflint = "tflint",
    thriftls = "thriftls",
    tinymist = "tinymist",
    ["tsp-server"] = "tsp_server",
    ["twiggy-language-server"] = "twiggy_language_server",
    ["typescript-language-server"] = "ts_ls",
    ["typos-lsp"] = "typos_lsp",
    ["unocss-language-server"] = "unocss",
    ["v-analyzer"] = "v_analyzer",
    vacuum = "vacuum",
    ["vala-language-server"] = "vala_ls",
    ["vale-ls"] = "vale_ls",
    verible = "verible",
    ["veryl-ls"] = "veryl_ls",
    ["vetur-vls"] = "vuels",
    ["vim-language-server"] = "vimls",
    ["visualforce-language-server"] = "visualforce_ls",
    vls = "vls",
    ["vscode-solidity-server"] = "solidity_ls",
    vtsls = "vtsls",
    ["vue-language-server"] = "volar",
    ["wgsl-analyzer"] = "wgsl_analyzer",
    ["yaml-language-server"] = "yamlls",
    zk = "zk",
    zls = "zls"
  }
}

local M = {}
M.m2l = function (mason_name)
  return data.mason_to_lspconfig[mason_name]
end
M.l2m = function (lspconfig_name)
  return data.lspconfig_to_mason[lspconfig_name]
end

return M
