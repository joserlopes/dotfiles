;; extends

((comment) @comment.documentation
  (#lua-match? @comment.documentation "^//[/!]")
  (#not-lua-match? @comment.documentation "^////"))
