
;---------------------------- cut here ----------------------------------
;* PUTSTR.INC is an include file to be used with HELLOM.ASM and
;* PUTSTR.ASM. It defines a prototype to be included by both
;* caller (HELLOM) and callee (PUTSTR) so that both get the same
;* procedure definition. PROTO also makes the procedure public
;* for the callee and external for the caller.

putstr  PROTO   string:PTR BYTE
