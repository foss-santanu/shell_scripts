:   "@(#)$Id: glint.sh,v 1.5 2002/08/09 21:40:52 jleffler Exp jleffler $"
#
#   Use GCC as excruciatingly pedantic lint
#   Not a complete replacement for lint -- it doesn't do inter-file checking.
#   Now configurable via the environment.
#   Use GLINT_EXTRA_FLAGS to set extra flags via the environment.
#   NB: much Solaris code won't work with -undef enabled.

: ${GLINT_GCC:='gcc'}

: ${GLINT_ANSI='-std=c99'}
: ${GLINT_FNO_COMMON='-fno-common'}
: ${GLINT_FSHORT_ENUMS='-fshort-enums'}
: ${GLINT_PEDANTIC='-pedantic'}
: ${GLINT_UNDEF='-undef'}
: ${GLINT_W='-W'}
: ${GLINT_WAGGREGATE_RETURN='-Waggregate-return'}
: ${GLINT_WALL='-Wall'}
: ${GLINT_WCAST_ALIGN='-Wcast-align'}
: ${GLINT_WCAST_QUAL='-Wcast-qual'}
: ${GLINT_WCONVERSION='-Wconversion'}
: ${GLINT_WMISSING_DECLARATIONS='-Wmissing-declarations'}
: ${GLINT_WREDUNDANT_DECLS='-Wredundant-decls'}
: ${GLINT_WMISSING_PROTOTYPES='-Wmissing-prototypes'}
: ${GLINT_WNESTED_EXTERNS='-Wnested-externs'}
: ${GLINT_WPOINTER_ARITH='-Wpointer-arith'}
: ${GLINT_WSHADOW='-Wshadow'}
: ${GLINT_WSTRICT_PROTOTYPES='-Wstrict-prototypes'}
: # ${GLINT_WTRADITIONAL='-Wtraditional'}
: ${GLINT_WWRITE_STRINGS='-Wwrite-strings'}

echo "${GLINT_GCC} ${GLINT_ANSI} ${GLINT_FNO_COMMON} ${GLINT_FSHORT_ENUMS} ${GLINT_PEDANTIC} ${GLINT_UNDEF} ${GLINT_WAGGREGATE_RETURN} ${GLINT_WALL} ${GLINT_WCAST_ALIGN} ${GLINT_WCAST_QUAL} ${GLINT_WCONVERSION} ${GLINT_WMISSING_DECLARATIONS} ${GLINT_WREDUNDANT_DECLS} ${GLINT_WMISSING_PROTOTYPES} ${GLINT_WNESTED_EXTERNS} ${GLINT_WPOINTER_ARITH} ${GLINT_WSHADOW} ${GLINT_WSTRICT_PROTOTYPES} ${GLINT_WTRADITIONAL} ${GLINT_WWRITE_STRINGS} ${GLINT_W} ${GLINT_EXTRA_FLAGS} -o /dev/null -O4 -g -c $*"

exec ${GLINT_GCC} \
    ${GLINT_ANSI} \
    ${GLINT_FNO_COMMON} \
    ${GLINT_FSHORT_ENUMS} \
    ${GLINT_PEDANTIC} \
    ${GLINT_UNDEF} \
    ${GLINT_WAGGREGATE_RETURN} \
    ${GLINT_WALL} \
    ${GLINT_WCAST_ALIGN} \
    ${GLINT_WCAST_QUAL} \
    ${GLINT_WCONVERSION} \
    ${GLINT_WMISSING_DECLARATIONS} \
    ${GLINT_WREDUNDANT_DECLS} \
    ${GLINT_WMISSING_PROTOTYPES} \
    ${GLINT_WNESTED_EXTERNS} \
    ${GLINT_WPOINTER_ARITH} \
    ${GLINT_WSHADOW} \
    ${GLINT_WSTRICT_PROTOTYPES} \
    ${GLINT_WTRADITIONAL} \
    ${GLINT_WWRITE_STRINGS} \
    ${GLINT_W} \
    ${GLINT_EXTRA_FLAGS} \
    -o /dev/null -O4 -g -c $*
