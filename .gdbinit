set history save on
set verbose off
set print pretty on
set print array off
set print array-indexes on
set python print-stack full

set breakpoint pending on
set confirm off
set disassembly-flavor intel

define skipstl
skip - gfile / usr/include/c++/**/bits/*
end

define skipstl_all
skip - gfile / usr/include/c++/**/bits/*
end
