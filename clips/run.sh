#!/bin/zsh
# Golden Fingers — LTX first/last-frame clips, ONE AT A TIME.
# usage: [SEED=n] zsh sites/golden-fingers/clips/run.sh [clip ids...]   (default: all, in order)
# waits until both keyframes exist; skips clips whose mp4 already exists.
cd /Users/anastasiia.krasnova/Projects/site-factory
PY=~/.local/share/itty-video/.venv/bin/python
K=sites/golden-fingers/kf
C=sites/golden-fingers/clips
PRE="One continuous shot, no cuts, photoreal, cinematic, bright natural light, silent, constant smooth speed, gentle parallax, nothing appears or disappears except what is described, no people, no hands."
NEG="hands, fingers, arms, people, person, human, face, body, barber, customer, mirror, reflection of a person, holding, grabbing, text, letters, numbers, logo, watermark, label, deformed scissors, melting metal, bent blade, extra scissors, duplicate objects, extra chairs, morphing objects, objects appearing, cuts, jittery, flicker, blurry, worst quality"
typeset -A A B P S
A[f1]=k1; B[f1]=k2; S[f1]=11; P[f1]="$PRE In an empty barbershop the camera performs a slow continuous dolly forward and to the left while tilting down toward the front of the white marble counter; the cool blue morning light slowly warms and soft sunbeam stripes settle across the scissors, razor, comb and clipper lying still on the marble."
A[f2]=k2; B[f2]=k3; S[f2]=12; P[f2]="$PRE The camera makes a slow lateral truck to the left along the white marble counter while lowering to counter height; from the rolled white towel on the brass tray soft white steam begins to rise and glows in the sunbeam from the window."
A[f3]=k3; B[f3]=k4; S[f3]=13; P[f3]="$PRE A very slow push-in with a slight rise toward the white ceramic shaving bowl on the marble; the steam drifts back out of focus, and inside the bowl thick white shaving foam slowly rises and swirls into a soft glossy peak."
A[f4]=k4; B[f4]=k5; S[f4]=14; P[f4]="$PRE The camera slowly descends to the level of the marble surface, moving slightly right; short dark hair clippings drift slowly down through a bright diagonal sunbeam and settle on the white marble around the open gold scissors, which lie perfectly still."
A[f6]=k6; B[f6]=k7; S[f6]=16; P[f6]="$PRE A slow arc of the camera downward from the high angle to counter height, pushing in toward the small round brass tin on the white marble; the light warms into golden hour and amber caustic light patterns slowly crawl across the marble. The objects lie perfectly still."
A[of]=o1; B[of]=o2; S[of]=21; P[of]="$PRE A slow steady forward dolly along the empty brick-paved shopping street toward the glowing barbershop window; the striped barber pole beside the window slowly turns; no people, no cars, no readable signs."
A[al]=a1; B[al]=a1; S[al]=31; P[al]="$PRE Locked-off static camera, the frame does not move. A thin wisp of steam rises gently from the rolled white towel, dust motes float in the sunbeam, the light breathes very slightly. Everything else is perfectly still."
A[cl]=c1; B[cl]=c1; S[cl]=41; P[cl]="$PRE Locked-off static camera, the frame does not move. The sheer linen curtain sways very gently, dust motes drift in the warm backlight, the striped barber pole outside turns very slowly. Everything else is perfectly still."
if (( $# )); then LIST=($@); else LIST=(f1 f2 f3 f4 f6 of al cl); fi
for c in $LIST; do
  out=$C/$c.mp4
  if [[ -f $out ]]; then echo "== $c exists, skip"; continue; fi
  a=$K/${A[$c]}.webp; b=$K/${B[$c]}.webp; n=0
  while [[ ! -f $a || ! -f $b ]]; do (( n++ % 20 == 0 )) && echo "   waiting for $a $b $(date +%T)"; sleep 30; (( n > 240 )) && break; done
  [[ -f $a && -f $b ]] || { echo "== $c SKIPPED (no keyframes)"; continue; }
  sd=${SEED:-${S[$c]}}
  echo "== clip $c seed $sd $(date +%T)"
  $PY tools/ltx_flf.py $a $b $out.tmp.mp4 --prompt "${P[$c]}" --neg "$NEG" --seed $sd 2>&1 | grep -E "ok |Error|error|Traceback"
  [[ -f $out.tmp.mp4 ]] && mv $out.tmp.mp4 $out
  echo "== done $c $(date +%T)"
done
echo "== ALL DONE $(date +%T)"
