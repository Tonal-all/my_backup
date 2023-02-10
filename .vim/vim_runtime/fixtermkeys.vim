function FixKey(key, fmt)
  exec printf("map  %s <S-%s>",     printf(a:fmt, 2), a:key)
  exec printf("map! %s <S-%s>",     printf(a:fmt, 2), a:key)
  exec printf("map  %s <A-%s>",     printf(a:fmt, 3), a:key)
  exec printf("map! %s <A-%s>",     printf(a:fmt, 3), a:key)
  exec printf("map  %s <A-S-%s>",   printf(a:fmt, 4), a:key)
  exec printf("map! %s <A-S-%s>",   printf(a:fmt, 4), a:key)
  exec printf("map  %s <C-%s>",     printf(a:fmt, 5), a:key)
  exec printf("map! %s <C-%s>",     printf(a:fmt, 5), a:key)
  exec printf("map  %s <C-S-%s>",   printf(a:fmt, 6), a:key)
  exec printf("map! %s <C-S-%s>",   printf(a:fmt, 6), a:key)
  exec printf("map  %s <C-A-%s>",   printf(a:fmt, 7), a:key)
  exec printf("map! %s <C-A-%s>",   printf(a:fmt, 7), a:key)
  exec printf("map  %s <C-A-S-%s>", printf(a:fmt, 8), a:key)
  exec printf("map! %s <C-A-S-%s>", printf(a:fmt, 8), a:key)
endfunction

function CSIu_Key(key, num)
  call FixKey(a:key, printf("<Esc>[%d;%%du", a:num))
  " Also handle <Esc>-prefixing
  exec printf("map  <Esc><%s> <A-%s>", a:key, a:key)
  exec printf("map! <Esc><%s> <A-%s>", a:key, a:key)
endfunction

function CSItilde_Key(key, num)
  call FixKey(a:key, printf("<Esc>[%d;%%d~", a:num))
endfunction

function CSI_Key(key, letter)
  call FixKey(a:key, printf("<Esc>[1;%%d%s", a:letter))
endfunction

call CSIu_Key("Tab",    9)
call CSIu_Key("CR",    13)
call CSIu_Key("Esc",   27)
call CSIu_Key("Space", 32)
call CSIu_Key("BS",   127)

for ch in [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, '-', '=', '.', ',']
  call FixKey(ch, printf("<Esc>[%d;%%du", char2nr(ch)))
  " Also handle <Esc>-prefixing
  exec printf("map  <Esc>%s <A-%s>", ch, ch)
  exec printf("map! <Esc>%s <A-%s>", ch, ch)
endfor

call CSItilde_Key("Insert",   2)
call CSItilde_Key("Delete",   3)
call CSItilde_Key("PageUp",   5)
call CSItilde_Key("PageDown", 6)

call CSI_Key("Up",    "A")
call CSI_Key("Down",  "B")
call CSI_Key("Right", "C")
call CSI_Key("Left",  "D")
call CSI_Key("End",   "F")
call CSI_Key("Home",  "H")

" Have to set a really short timeoutlen now, so that these mappings work
" nicely
set timeoutlen=50
