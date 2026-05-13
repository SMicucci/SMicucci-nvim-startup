; extends

; sql
((comment) @_comment . (assignment_statement right: (expression_list (interpreted_string_literal (interpreted_string_literal_content) @injection.content)))
 (#lua-match? @_comment "language=sql")
 (#set! injection.language "sql"))
((comment) @_comment . (assignment_statement right: (expression_list (raw_string_literal) @injection.content))
 (#lua-match? @_comment "language=sql")
 (#set! injection.language "sql"))

; json
((comment) @_comment . (assignment_statement right: (expression_list (interpreted_string_literal (interpreted_string_literal_content) @injection.content)))
 (#lua-match? @_comment "language=json")
 (#set! injection.language "json"))
((comment) @_comment . (assignment_statement right: (expression_list (raw_string_literal) @injection.content))
 (#lua-match? @_comment "language=json")
 (#set! injection.language "json"))

; xml
((comment) @_comment . (assignment_statement right: (expression_list (interpreted_string_literal (interpreted_string_literal_content) @injection.content)))
 (#lua-match? @_comment "language=xml")
 (#set! injection.language "xml"))
((comment) @_comment . (assignment_statement right: (expression_list (raw_string_literal) @injection.content))
 (#lua-match? @_comment "language=xml")
 (#set! injection.language "xml"))

; yaml
((comment) @_comment . (assignment_statement right: (expression_list (interpreted_string_literal (interpreted_string_literal_content) @injection.content)))
 (#lua-match? @_comment "language=yaml")
 (#set! injection.language "yaml"))
((comment) @_comment . (assignment_statement right: (expression_list (raw_string_literal) @injection.content))
 (#lua-match? @_comment "language=yaml")
 (#set! injection.language "yaml"))

; toml
((comment) @_comment . (assignment_statement right: (expression_list (interpreted_string_literal (interpreted_string_literal_content) @injection.content)))
 (#lua-match? @_comment "language=toml")
 (#set! injection.language "toml"))
((comment) @_comment . (assignment_statement right: (expression_list (raw_string_literal) @injection.content))
 (#lua-match? @_comment "language=toml")
 (#set! injection.language "toml"))

; lua
((comment) @_comment . (assignment_statement right: (expression_list (interpreted_string_literal (interpreted_string_literal_content) @injection.content)))
 (#lua-match? @_comment "language=lua")
 (#set! injection.language "lua"))
((comment) @_comment . (assignment_statement right: (expression_list (raw_string_literal) @injection.content))
 (#lua-match? @_comment "language=lua")
 (#set! injection.language "lua"))

; html
((comment) @_comment . (assignment_statement right: (expression_list (interpreted_string_literal (interpreted_string_literal_content) @injection.content)))
 (#lua-match? @_comment "language=html")
 (#set! injection.language "html"))
((comment) @_comment . (assignment_statement right: (expression_list (raw_string_literal) @injection.content))
 (#lua-match? @_comment "language=html")
 (#set! injection.language "html"))
