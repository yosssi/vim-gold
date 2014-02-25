" Vim syntax file
" Language: Gold
" Maintainer: Keiji Yoshida <yoshida.keiji.84@gmail.com>
" Version:  1
" Last Change:  2014 Feb 26

" Quit when a syntax file is already loaded.
if exists("b:current_syntax")
  finish
endif

if !exists("main_syntax")
  let main_syntax = 'gold'
endif

" Allows a per line syntax evaluation.
let b:ruby_no_expensive = 1

" Include Ruby syntax highlighting
syn include @goldRubyTop syntax/ruby.vim
unlet! b:current_syntax
" Include Haml syntax highlighting
syn include @goldHaml syntax/haml.vim
unlet! b:current_syntax

syn match goldBegin  "^\s*\(&[^= ]\)\@!" nextgroup=goldTag,goldClassChar,goldIdChar,goldRuby

syn region  rubyCurlyBlock start="{" end="}" contains=@goldRubyTop contained
syn cluster goldRubyTop    add=rubyCurlyBlock

syn cluster goldComponent contains=goldClassChar,goldIdChar,goldWrappedAttrs,goldRuby,goldAttr,goldInlineTagChar

syn keyword goldDocType        contained html 5 1.1 strict frameset mobile basic transitional
syn match   goldDocTypeKeyword "^\s*\(doctype\)\s\+" nextgroup=goldDocType

syn keyword goldTodo        FIXME TODO NOTE OPTIMIZE XXX contained

syn match goldTag           "\w\+"         contained contains=htmlTagName nextgroup=@goldComponent
syn match goldIdChar        "#{\@!"        contained nextgroup=goldId
syn match goldId            "\%(\w\|-\)\+" contained nextgroup=@goldComponent
syn match goldClassChar     "\."           contained nextgroup=goldClass
syn match goldClass         "\%(\w\|-\)\+" contained nextgroup=@goldComponent
syn match goldInlineTagChar "\s*:\s*"      contained nextgroup=goldTag,goldClassChar,goldIdChar

syn region goldWrappedAttrs matchgroup=goldWrappedAttrsDelimiter start="\s*{\s*" skip="}\s*\""  end="\s*}\s*"  contained contains=goldAttr nextgroup=goldRuby
syn region goldWrappedAttrs matchgroup=goldWrappedAttrsDelimiter start="\s*\[\s*" end="\s*\]\s*" contained contains=goldAttr nextgroup=goldRuby
syn region goldWrappedAttrs matchgroup=goldWrappedAttrsDelimiter start="\s*(\s*"  end="\s*)\s*"  contained contains=goldAttr nextgroup=goldRuby

syn match goldAttr "\s*\%(\w\|-\)\+\s*" contained contains=htmlArg nextgroup=goldAttrAssignment
syn match goldAttrAssignment "\s*=\s*" contained nextgroup=goldWrappedAttrValue,goldAttrString

syn region goldWrappedAttrValue matchgroup=goldWrappedAttrValueDelimiter start="{" end="}" contained contains=goldAttrString,@goldRubyTop nextgroup=goldAttr,goldRuby,goldInlineTagChar
syn region goldWrappedAttrValue matchgroup=goldWrappedAttrValueDelimiter start="\[" end="\]" contained contains=goldAttrString,@goldRubyTop nextgroup=goldAttr,goldRuby,goldInlineTagChar
syn region goldWrappedAttrValue matchgroup=goldWrappedAttrValueDelimiter start="(" end=")" contained contains=goldAttrString,@goldRubyTop nextgroup=goldAttr,goldRuby,goldInlineTagChar

syn region goldAttrString start=+\s*"+ skip=+\%(\\\\\)*\\"+ end=+"\s*+ contained contains=goldInterpolation,goldInterpolationEscape nextgroup=goldAttr,goldRuby,goldInlineTagChar
syn region goldAttrString start=+\s*'+ skip=+\%(\\\\\)*\\"+ end=+'\s*+ contained contains=goldInterpolation,goldInterpolationEscape nextgroup=goldAttr,goldRuby,goldInlineTagChar

syn region goldInnerAttrString start=+\s*"+ skip=+\%(\\\\\)*\\"+ end=+"\s*+ contained contains=goldInterpolation,goldInterpolationEscape nextgroup=goldAttr
syn region goldInnerAttrString start=+\s*'+ skip=+\%(\\\\\)*\\"+ end=+'\s*+ contained contains=goldInterpolation,goldInterpolationEscape nextgroup=goldAttr

syn region goldInterpolation matchgroup=goldInterpolationDelimiter start="#{" end="}" contains=@hamlRubyTop containedin=javascriptStringS,javascriptStringD,goldWrappedAttrs
syn match  goldInterpolationEscape "\\\@<!\%(\\\\\)*\\\%(\\\ze#{\|#\ze{\)"

syn region goldRuby matchgroup=goldRubyOutputChar start="\s*[=]\==[']\=" skip=",\s*$" end="$" contained contains=@goldRubyTop keepend
syn region goldRuby matchgroup=goldRubyChar       start="\s*-"           skip=",\s*$" end="$" contained contains=@goldRubyTop keepend

syn match goldComment /^\(\s*\)[/].*\(\n\1\s.*\)*/ contains=goldTodo
syn match goldText    /^\(\s*\)[`|'].*\(\n\1\s.*\)*/

syn match goldFilter /\s*\w\+:\s*/                            contained
syn match goldHaml   /^\(\s*\)\<haml:\>.*\(\n\1\s.*\)*/       contains=@goldHaml,goldFilter

syn match goldIEConditional "\%(^\s*/\)\@<=\[\s*if\>[^]]*]" contained containedin=goldComment

hi def link goldAttrString                String
hi def link goldBegin                     String
hi def link goldClass                     Type
hi def link goldClassChar                 Type
hi def link goldComment                   Comment
hi def link goldDocType                   Identifier
hi def link goldDocTypeKeyword            Keyword
hi def link goldFilter                    Keyword
hi def link goldIEConditional             SpecialComment
hi def link goldId                        Identifier
hi def link goldIdChar                    Identifier
hi def link goldInnerAttrString           String
hi def link goldInterpolationDelimiter    Delimiter
hi def link goldRubyChar                  Special
hi def link goldRubyOutputChar            Special
hi def link goldText                      String
hi def link goldTodo                      Todo
hi def link goldWrappedAttrValueDelimiter Delimiter
hi def link goldWrappedAttrsDelimiter     Delimiter
hi def link goldInlineTagChar             Delimiter

let b:current_syntax = "gold"
