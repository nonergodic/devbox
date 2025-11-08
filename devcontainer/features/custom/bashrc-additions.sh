h2d(){
  tmp=${@#"0x"}
  tmp=`echo "$tmp" | tr '[:lower:]' '[:upper:]'`
  echo "ibase=16; $tmp" | bc
}
d2h(){
  tmp=`echo "obase=16; $@" | bc`
  echo "0x$tmp" | tr '[:upper:]' '[:lower:]'
}
h2a() {
  local s=${1#0x}
  s=${s^^}
  local c=${2:-1}
  local w=$((c*2))

  (( ${#s} & 1 )) && {
    printf 'error: odd number of hex digits %d\n' "${#s}" >&2
    return 1
  }

  local bytes=$(( ${#s} / 2 ))
  (( bytes % c == 0 )) || {
    printf 'error: hex len %d but chunk size %d\n' "$bytes" "$c" >&2
    return 1
  }

  local sep='['
  for ((i=0;i<${#s};i+=w)); do
    printf '%s%u' "$sep" $((16#${s:i:w}))
    sep=','
  done
  printf ']\n'
}

function up() {
  local count=${1:-1}  # Default to 1 level if no parameter is provided
  local dir=""
  for ((i=0; i<count; i++)); do
    dir+="../"
  done
  cd $dir || return  # Change to the directory or return on failure
}

alias ll='ls -al'
