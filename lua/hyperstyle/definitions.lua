-- CSS property and statement definitions for hyperstyle
-- Converted from Python definitions.py

local M = {}

-- Properties list: {property, aliases, unit, values}
-- property: (String) the full CSS property name
-- aliases: (String list) a list of aliases for this shortcut
-- unit: (String) default unit for values, "_" for unitless numbers
-- values: (String list) possible values for this property
M.properties = {
  {"margin", {}, "px", {"auto"}},
  {"width", {}, "px", {"auto"}},
  {"height", {}, "px", {"auto"}},
  {"padding", {}, "px", {"auto"}},
  {"border", {}, nil, nil},
  {"outline", {}, nil, nil},
  {"left", {}, "px", nil},
  {"top", {}, "px", nil},
  {"bottom", {}, "px", nil},
  {"right", {}, "px", nil},
  {"background", {"bground"}, nil, {"transparent"}},
  {"min-height", {"mheight"}, "px", {"auto"}},
  {"min-width", {"mwidth"}, "px", {"auto"}},
  {"max-height", {"xheight", "mxheight"}, "px", {"auto"}},
  {"max-width", {"xwidth", "mxheight"}, "px", {"auto"}},

  {"margin-left", {"mleft", "marleft"}, "px", {"auto"}},
  {"margin-right", {"mright", "marright"}, "px", {"auto"}},
  {"margin-top", {"mtop", "martop"}, "px", {"auto"}},
  {"margin-bottom", {"mbottom", "marbottom"}, "px", {"auto"}},

  {"padding-left", {"pleft", "padleft"}, "px", nil},
  {"padding-right", {"pright", "padright"}, "px", nil},
  {"padding-top", {"ptop", "padtop"}, "px", nil},
  {"padding-bottom", {"pbottom", "padbottom"}, "px", nil},

  {"z-index", {}, "_", nil},

  {"display", {}, nil, {"none", "block", "inline", "inline-block", "table", "table-cell", "table-row"}},
  {"text-align", {"talign"}, nil, {"left", "right", "justify", "center", "inherit"}},

  {"overflow", {"oflow"}, nil, {"visible", "scroll", "hidden", "auto", "inherit"}},
  {"overflow-x", {"ox"}, nil, {"visible", "scroll", "hidden", "auto", "inherit"}},
  {"overflow-y", {"oy"}, nil, {"visible", "scroll", "hidden", "auto", "inherit"}},

  {"font", {}, nil, nil},
  {"font-size", {"fsize", "fosize"}, "em", nil},
  {"font-style", {"fstyle", "fostyle"}, nil, {"italic", "normal", "inherit"}},
  {"font-weight", {"fweight", "foweight"}, nil, {"100", "200", "300", "400", "500", "600", "700", "800", "900", "bold", "normal", "inherit"}},
  {"font-variant", {"fvariant", "fovariant"}, nil, nil},
  {"font-family", {"ffamily", "family"}, nil, nil},
  {"line-height", {"lheight", "liheight"}, "_", nil},
  {"letter-spacing", {"lspacing", "lespacing"}, "px", nil},

  {"transition", {"trans", "tn", "tsition"}, nil, nil},
  {"transform", {"tform", "xform"}, nil, nil},
  {"text-transform", {"ttransform"}, nil, {"uppercase", "lowercase", "capitalize", "none", "full-width", "inherit"}},
  {"text-decoration", {"tdecoration"}, nil, {"underline", "none", "line-through", "overline", "inherit", "initial"}},
  {"text-decoration-line", {"tdline"}, nil, {"underline", "none", "line-through", "overline", "inherit", "initial"}},
  {"text-indent", {"tindent"}, "px", nil},
  {"text-shadow", {"tshadow", "teshadow"}, nil, {"none"}},
  {"table-layout", {"tlayout", "talayout"}, nil, {"fixed", "auto", "inherit"}},
  {"vertical-align", {"valign"}, nil, {"middle", "top", "bottom", "baseline", "text-top", "text-bottom", "sub", "super"}},

  {"transition-duration", {"tduration"}, "ms", nil},

  {"float", {}, nil, {"left", "right", "none", "inherit"}},
  {"color", {}, nil, nil},
  {"opacity", {}, "_", nil},

  {"border-right", {"bright", "borright"}, nil, nil},
  {"border-left", {"bleft", "borleft"}, nil, nil},
  {"border-top", {"btop", "bortop"}, nil, nil},
  {"border-bottom", {"bbottom", "borbottom"}, nil, nil},

  {"border-width", {"bwidth"}, "px", nil},
  {"border-right-width", {"brwidth"}, "px", nil},
  {"border-left-width", {"blwidth"}, "px", nil},
  {"border-top-width", {"btwidth"}, "px", nil},
  {"border-bottom-width", {"bbwidth"}, "px", nil},

  {"border-image", {"borimage"}, nil, nil},

  {"cursor", {}, nil, {"wait", "pointer", "auto", "default", "help", "progress", "cell", "crosshair", "text", "vertical-text", "alias", "copy", "move", "not-allowed", "no-drop", "all-scroll", "col-resize", "row-resize", "n-resize", "e-resize", "s-resize", "w-resize", "nw-resize", "ne-resize", "sw-resize", "se-resize", "ew-resize", "ns-resize", "zoom-in", "zoom-out", "grab", "grabbing"}},
  {"animation", {}, nil, nil},

  {"background-image", {"bgimage", "backimage", "bimage"}, nil, nil},
  {"background-color", {"bgcolor", "backcolor", "bcolor"}, nil, nil},
  {"background-size", {"bgsize", "backsize"}, nil, nil},
  {"background-position", {"bgposition", "backposition", "bposition"}, nil, {"center", "top", "left", "middle", "bottom", "right"}},
  {"background-repeat", {"bgrepeat", "backrepeat", "brepeat"}, nil, {"repeat-x", "repeat-y", "no-repeat"}},

  {"border-radius", {"bradius", "boradius"}, "px", nil},
  {"border-color", {"bcolor", "bocolor", "borcolor"}, "px", nil},
  {"border-collapse", {"bcollapse", "borcollapse", "collapse"}, nil, {"collapse", "auto", "inherit"}},

  {"box-shadow", {"bshadow", "boshadow"}, nil, {"none"}},
  {"box-sizing", {"bsizing", "bsize", "boxsize"}, nil, {"border-box", "content-box", "padding-box"}},

  {"position", {}, nil, {"absolute", "relative", "fixed", "static", "inherit"}},
  {"flex", {}, nil, nil},
  {"white-space", {"wspace", "whispace", "whspace", "wispace"}, nil, {"nowrap", "normal", "pre", "pre-wrap", "pre-line", "inherit"}},

  {"visibility", {}, nil, {"visible", "hidden", "collapse", "inherit"}},

  {"flex-grow", {"fgrow", "flgrow", "flegrow"}, "_", nil},
  {"flex-shrink", {"fshrink", "flshrink", "fleshrink"}, "_", nil},
  {"flex-direction", {"fdirection", "fldirection", "fledirection"}, nil, nil},
  {"flex-wrap", {"fwrap", "flwrap", "flewrap"}, nil, nil},
  {"align-items", {"aitems", "alitems"}, nil, {"flex-start", "flex-end", "center", "baseline", "stretch", "inherit"}},
  {"justify-content", {"jcontent", "jucontent", "juscontent", "justcontent"}, nil, {"flex-start", "flex-end", "center", "space-around", "space-between", "inherit"}},
  {"order", {}, "_", nil},

  {"page-break-after", {"pbafter"}, nil, {"always", "auto", "avoid", "left", "right", "inherit"}},
  {"page-break-before", {"pbbefore"}, nil, {"always", "auto", "avoid", "left", "right", "inherit"}},
  {"perspective", {}, nil, nil},
  {"perspective-origin", {"porigin"}, nil, nil},
  {"word-break", {"wbreak"}, nil, {}},
  {"quotes", {}, nil, nil},
  {"content", {}, nil, nil},
  {"clear", {}, nil, {"left", "right", "both", "inherit"}},
  {"zoom", {}, "_", nil},
  {"direction", {}, nil, {"ltr", "rtl", "inherit"}},

  {"list-style", {"lstyle"}, nil, {"none", "square", "disc", "inside", "outside", "inherit", "initial", "unset", "decimal", "georgian"}},
}

-- Statements list: {property, value, aliases}
-- Shortcuts for complete CSS statements
M.statements = {
  {"display", "block", {"dblock"}},
  {"display", "inline", {"dinline"}},
  {"display", "inline-block", {"diblock"}},
  {"display", "inline-flex", {"diflex"}},
  {"display", "table", {"dtable", "table"}},
  {"display", "table-cell", {"dtcell", "cell", "tablecell", "table-cell"}},
  {"display", "table-row", {"dtrow", "row", "tablerow", "table-row"}},

  {"float", "left", {"fleft", "flleft", "floleft"}},
  {"float", "right", {"fright", "flright", "floright"}},
  {"float", "none", {"fnone", "flnone", "flonone"}},

  {"display", "none", {"dnone"}},
  {"display", "flex", {"dflex", "flex"}},

  {"font-weight", "normal", {"fwnormal"}},
  {"font-weight", "bold", {"fwbold", "bold"}},
  {"font-style", "italic", {"fsitalic", "italic"}},
  {"font-style", "normal", {"fnormal"}},

  {"border", "0", {"b0"}},
  {"padding", "0", {"p0", "po"}},
  {"margin", "0", {"m0", "mo"}},
  {"margin", "0 auto", {"m0a", "moa"}},

  {"overflow", "hidden", {"ohidden"}},
  {"overflow", "scroll", {"oscroll"}},
  {"overflow", "auto", {"oauto"}},
  {"overflow", "visible", {"ovisible"}},

  {"overflow-x", "hidden", {"oxhidden"}},
  {"overflow-x", "scroll", {"oxscroll"}},
  {"overflow-x", "auto", {"oxauto"}},
  {"overflow-x", "visible", {"oxvisible"}},

  {"overflow-y", "hidden", {"oyhidden"}},
  {"overflow-y", "scroll", {"oyscroll"}},
  {"overflow-y", "auto", {"oyauto"}},
  {"overflow-y", "visible", {"oyvisible"}},

  {"font-weight", "100", {"f100", "fw100"}},
  {"font-weight", "200", {"f200", "fw200"}},
  {"font-weight", "300", {"f300", "fw300"}},
  {"font-weight", "400", {"f400", "fw400"}},
  {"font-weight", "500", {"f500", "fw500"}},
  {"font-weight", "600", {"f600", "fw600"}},
  {"font-weight", "700", {"f700", "fw700"}},
  {"font-weight", "800", {"f800", "fw800"}},
  {"font-weight", "900", {"f900", "fw900"}},

  {"border", "0", {"b0"}},
  {"border-collapse", "collapse", {"bccollapse"}},
  {"border-collapse", "separate", {"bcseparate"}},

  {"background-repeat", "repeat-x", {"brx", "rx", "bgrx", "repeatx"}},
  {"background-repeat", "repeat-y", {"bry", "ry", "bgry", "repeaty"}},
  {"background-repeat", "no-repeat", {"brnorepeat", "norepeat"}},

  {"background-size", "cover", {"cover"}},
  {"background-size", "contain", {"contain"}},

  {"cursor", "pointer", {"cupointer", "curpointer"}},
  {"cursor", "wait", {"cuwait", "curwait"}},
  {"cursor", "busy", {"cubusy", "curbusy"}},
  {"cursor", "text", {"cutext", "curtext"}},

  {"vertical-align", "middle", {"vamiddle"}},
  {"vertical-align", "top", {"vatop"}},
  {"vertical-align", "bottom", {"vabottom"}},
  {"vertical-align", "sub", {"vasub"}},
  {"vertical-align", "super", {"vasuper"}},
  {"vertical-align", "baseline", {"vabline", "vabaseline", "baseline"}},
  {"vertical-align", "text-top", {"vattop"}},
  {"vertical-align", "text-bottom", {"vattbottom"}},

  {"visibility", "visible", {"vvisible", "visible"}},
  {"visibility", "hidden", {"vhidden", "vishidden", "vihidden", "hidden", "hide"}},
  {"visibility", "collapse", {"vcollapse", "viscollapse", "vicollapse"}},

  {"clear", "both", {"cboth"}},
  {"clear", "right", {"cright"}},
  {"clear", "left", {"cleft"}},

  {"content", "''", {"content"}},

  {"text-transform", "uppercase", {"ttupper", "uppercase"}},
  {"text-transform", "lowercase", {"ttlower"}},
  {"text-transform", "none", {"ttnone"}},
  {"text-transform", "capitalize", {"ttcap"}},
  {"text-transform", "full-width", {"ttfull"}},

  {"text-align", "left", {"taleft"}},
  {"text-align", "right", {"taright"}},
  {"text-align", "center", {"tacenter", "center"}},
  {"text-align", "justify", {"tajustify", "justify"}},

  {"text-decoration", "underline", {"tdunderline", "underline"}},
  {"text-decoration", "none", {"tdnone"}},

  {"box-sizing", "border-box", {"bsbox"}},
  {"box-sizing", "padding-box", {"bspadding"}},
  {"box-sizing", "content-box", {"bscontent"}},

  {"margin", "auto", {"mauto"}},
  {"margin-left", "auto", {"mlauto"}},
  {"margin-right", "auto", {"mrauto"}},

  {"width", "auto", {"wauto"}},
  {"height", "auto", {"hauto"}},

  {"position", "relative", {"porelative", "prelative", "relative"}},
  {"position", "fixed", {"pofixed", "pfixed", "fixed"}},
  {"position", "static", {"postatic", "pstatic", "static"}},
  {"position", "absolute", {"poabsolute", "pabsolute", "absolute"}},

  {"white-space", "nowrap", {"nowrap"}},
  {"text-overflow", "ellipsis", {"ellipsis"}},

  {"flex", "auto", {"flauto"}},

  {"align-items", "flex-start", {"aistart"}},
  {"align-items", "flex-end", {"aiend"}},
  {"align-items", "center", {"aicenter"}},
  {"align-items", "stretch", {"aistretch"}},

  {"text-overflow", "ellipsis", {"elip", "ellipsis", "toellipsis"}},

  {"flex-wrap", "wrap", {"fwrap", "flexwrap"}},
  {"flex-wrap", "nowrap", {"fnowrap"}},

  {"flex-direction", "row", {"fdrow"}},
  {"flex-direction", "row-reverse", {"fdrreverse"}},
  {"flex-direction", "column", {"fdcolumn"}},
  {"flex-direction", "column-reverse", {"fdcreverse"}},

  {"justify-content", "center", {"jccenter"}},
  {"justify-content", "flex-start", {"jcstart"}},
  {"justify-content", "flex-end", {"jcend"}},

  {"direction", "ltr", {"ltr", "dirltr"}},
  {"direction", "rtl", {"rtl", "dirrtl"}},

  {"text-shadow", "none", {"tsnone", "teshnone"}},
  {"table-layout", "fixed", {"tlfixed"}},
  {"table-layout", "auto", {"tlauto"}},

  {"list-style", "none", {"lsnone"}},
  {"list-style-type", "none", {"lstnone"}},
}

M.definitions = {
  properties = M.properties,
  statements = M.statements
}

return M