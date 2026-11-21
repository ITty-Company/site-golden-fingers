#!/bin/zsh
# Golden Fingers — retry one clip with a new seed/prompt, after run.sh has finished.
# usage: zsh retry.sh <id> <A> <B> <seed> "<prompt>"   -> clips/<id>.mp4
cd /Users/anastasiia.krasnova/Projects/site-factory
PY=~/.local/share/itty-video/.venv/bin/python
K=sites/golden-fingers/kf; C=sites/golden-fingers/clips
while pgrep -f "golden-fingers/clips/run.sh" >/dev/null; do sleep 20; done
while pgrep -f ltx_flf.py >/dev/null; do sleep 20; done
NEG="hands, fingers, arms, people, person, human, face, body, mirror, holding, text, letters, numbers, logo, watermark, label, deformed scissors, melting metal, bent blade, extra scissors, duplicate objects, duplicate counter, extra chairs, morphing objects, morphing furniture, objects appearing, ghosting, double exposure, crossfade, cuts, jittery, flicker, blurry, worst quality"
echo "== retry $1 seed $4 $(date +%T)"
$PY tools/ltx_flf.py $K/$2.webp $K/$3.webp $C/$1.tmp.mp4 --prompt "$5" --neg "$NEG" --seed $4 2>&1 | grep -E "ok |Error|error|Traceback"
[[ -f $C/$1.tmp.mp4 ]] && mv $C/$1.tmp.mp4 $C/$1.mp4
echo "== retry done $1 $(date +%T)"
