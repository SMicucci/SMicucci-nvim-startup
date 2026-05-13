; extends

; sql
((comment) @_comment . (expression_statement (assignment right: (string (string_content)@injection.content)))
           (#lua-match? @_comment "language=sql")
           (#set! injection.language "sql"))

; json
((comment) @_comment . (expression_statement (assignment right: (string (string_content)@injection.content)))
           (#lua-match? @_comment "language=json")
           (#set! injection.language "json"))

; xml
((comment) @_comment . (expression_statement (assignment right: (string (string_content)@injection.content)))
           (#lua-match? @_comment "language=xml")
           (#set! injection.language "xml"))

; yaml
((comment) @_comment . (expression_statement (assignment right: (string (string_content)@injection.content)))
           (#lua-match? @_comment "language=yaml")
           (#set! injection.language "yaml"))

; toml
((comment) @_comment . (expression_statement (assignment right: (string (string_content)@injection.content)))
           (#lua-match? @_comment "language=toml")
           (#set! injection.language "toml"))

; lua
((comment) @_comment . (expression_statement (assignment right: (string (string_content)@injection.content)))
           (#lua-match? @_comment "language=lua")
           (#set! injection.language "lua"))

; html
((comment) @_comment . (expression_statement (assignment right: (string (string_content)@injection.content)))
           (#lua-match? @_comment "language=html")
           (#set! injection.language "html"))
