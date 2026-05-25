; extends

; sql
((comment) @_comment .
           (declaration declarator: (init_declarator value: (string_literal (string_content)@injection.content)))
           (#lua-match? @_comment "language=sql")
           (#set! injection.language "sql"))
((comment) @_comment .
           (expression_statement (assignment_expression right: (string_literal (string_content) @injection.content)))
           (#lua-match? @_comment "language=sql")
           (#set! injection.language "sql"))
((comment) @_comment .
           (declaration declarator: (init_declarator value: (concatenated_string (string_literal (string_content)@injection.content))))
           (#lua-match? @_comment "language=sql")
           (#set! injection.language "sql")
           (#set! injection.combined))
((comment) @_comment .
           (expression_statement (assignment_expression right: (concatenated_string (string_literal (string_content) @injection.content))))
           (#lua-match? @_comment "language=sql")
           (#set! injection.language "sql")
           (#set! injection.combined))

; json
((comment) @_comment .
           (declaration declarator: (init_declarator value: (string_literal (string_content)@injection.content)))
           (#lua-match? @_comment "language=json")
           (#set! injection.language "json"))
((comment) @_comment .
           (expression_statement (assignment_expression right: (string_literal (string_content) @injection.content)))
           (#lua-match? @_comment "language=json")
           (#set! injection.language "json"))
((comment) @_comment .
           (declaration declarator: (init_declarator value: (concatenated_string (string_literal (string_content)@injection.content))))
           (#lua-match? @_comment "language=json")
           (#set! injection.language "json")
           (#set! injection.combined))
((comment) @_comment .
           (expression_statement (assignment_expression right: (concatenated_string (string_literal (string_content) @injection.content))))
           (#lua-match? @_comment "language=json")
           (#set! injection.language "json")
           (#set! injection.combined))

; xml
((comment) @_comment .
           (declaration declarator: (init_declarator value: (string_literal (string_content)@injection.content)))
           (#lua-match? @_comment "language=xml")
           (#set! injection.language "xml"))
((comment) @_comment .
           (expression_statement (assignment_expression right: (string_literal (string_content) @injection.content)))
           (#lua-match? @_comment "language=xml")
           (#set! injection.language "xml"))
((comment) @_comment .
           (declaration declarator: (init_declarator value: (concatenated_string (string_literal (string_content)@injection.content))))
           (#lua-match? @_comment "language=xml")
           (#set! injection.language "xml")
           (#set! injection.combined))
((comment) @_comment .
           (expression_statement (assignment_expression right: (concatenated_string (string_literal (string_content) @injection.content))))
           (#lua-match? @_comment "language=xml")
           (#set! injection.language "xml")
           (#set! injection.combined))

; yaml
((comment) @_comment .
           (declaration declarator: (init_declarator value: (string_literal (string_content)@injection.content)))
           (#lua-match? @_comment "language=yaml")
           (#set! injection.language "yaml"))
((comment) @_comment .
           (expression_statement (assignment_expression right: (string_literal (string_content) @injection.content)))
           (#lua-match? @_comment "language=yaml")
           (#set! injection.language "yaml"))
((comment) @_comment .
           (declaration declarator: (init_declarator value: (concatenated_string (string_literal (string_content)@injection.content))))
           (#lua-match? @_comment "language=yaml")
           (#set! injection.language "yaml")
           (#set! injection.combined))
((comment) @_comment .
           (expression_statement (assignment_expression right: (concatenated_string (string_literal (string_content) @injection.content))))
           (#lua-match? @_comment "language=yaml")
           (#set! injection.language "yaml")
           (#set! injection.combined))

; toml
((comment) @_comment .
           (declaration declarator: (init_declarator value: (string_literal (string_content)@injection.content)))
           (#lua-match? @_comment "language=toml")
           (#set! injection.language "toml"))
((comment) @_comment .
           (expression_statement (assignment_expression right: (string_literal (string_content) @injection.content)))
           (#lua-match? @_comment "language=toml")
           (#set! injection.language "toml"))
((comment) @_comment .
           (declaration declarator: (init_declarator value: (concatenated_string (string_literal (string_content)@injection.content))))
           (#lua-match? @_comment "language=toml")
           (#set! injection.language "toml")
           (#set! injection.combined))
((comment) @_comment .
           (expression_statement (assignment_expression right: (concatenated_string (string_literal (string_content) @injection.content))))
           (#lua-match? @_comment "language=toml")
           (#set! injection.language "toml")
           (#set! injection.combined))

; lua
((comment) @_comment .
           (declaration declarator: (init_declarator value: (string_literal (string_content)@injection.content)))
           (#lua-match? @_comment "language=lua")
           (#set! injection.language "lua"))
((comment) @_comment .
           (expression_statement (assignment_expression right: (string_literal (string_content) @injection.content)))
           (#lua-match? @_comment "language=lua")
           (#set! injection.language "lua"))
((comment) @_comment .
           (declaration declarator: (init_declarator value: (concatenated_string (string_literal (string_content)@injection.content))))
           (#lua-match? @_comment "language=lua")
           (#set! injection.language "lua")
           (#set! injection.combined))
((comment) @_comment .
           (expression_statement (assignment_expression right: (concatenated_string (string_literal (string_content) @injection.content))))
           (#lua-match? @_comment "language=lua")
           (#set! injection.language "lua")
           (#set! injection.combined))

; html
((comment) @_comment .
           (declaration declarator: (init_declarator value: (string_literal (string_content)@injection.content)))
           (#lua-match? @_comment "language=html")
           (#set! injection.language "html"))
((comment) @_comment .
           (expression_statement (assignment_expression right: (string_literal (string_content) @injection.content)))
           (#lua-match? @_comment "language=html")
           (#set! injection.language "html"))
((comment) @_comment .
           (declaration declarator: (init_declarator value: (concatenated_string (string_literal (string_content)@injection.content))))
           (#lua-match? @_comment "language=html")
           (#set! injection.language "html")
           (#set! injection.combined))
((comment) @_comment .
           (expression_statement (assignment_expression right: (concatenated_string (string_literal (string_content) @injection.content))))
           (#lua-match? @_comment "language=html")
           (#set! injection.language "html")
           (#set! injection.combined))

; tcl
((comment) @_comment .
           (declaration declarator: (init_declarator value: (string_literal (string_content)@injection.content)))
           (#lua-match? @_comment "language=tcl")
           (#set! injection.language "tcl"))
((comment) @_comment .
           (expression_statement (assignment_expression right: (string_literal (string_content) @injection.content)))
           (#lua-match? @_comment "language=tcl")
           (#set! injection.language "tcl"))
((comment) @_comment .
           (declaration declarator: (init_declarator value: (concatenated_string (string_literal (string_content)@injection.content))))
           (#lua-match? @_comment "language=tcl")
           (#set! injection.language "tcl")
           (#set! injection.combined))
((comment) @_comment .
           (expression_statement (assignment_expression right: (concatenated_string (string_literal (string_content) @injection.content))))
           (#lua-match? @_comment "language=tcl")
           (#set! injection.language "tcl")
           (#set! injection.combined))
