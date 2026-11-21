#!/bin/zsh
# sequential retry chain (one clip at a time)
cd /Users/anastasiia.krasnova/Projects/site-factory
R=sites/golden-fingers/clips/retry.sh
PRE="One continuous shot, no cuts, photoreal, cinematic, bright natural light, silent, constant smooth speed, gentle parallax, no people, no hands."
zsh $R f1b k1 k2 57 "$PRE In an empty barbershop the camera glides slowly forward and slightly left toward the single long white marble counter, tilting down a little; the counter, the barber chair and all objects keep exactly their shape and position; the cool morning light gently warms."
zsh $R f3b k3 k4 63 "$PRE The camera slowly pushes in toward the white ceramic shaving bowl on the marble counter; the rolled towel on its brass tray stays in place in the background; white shaving foam slowly rises in the bowl into a soft peak. All objects keep their shape and position."
zsh $R f4b k4 k5 74 "$PRE The camera slowly lowers toward the marble surface; the shaving bowl stays in place and drifts out of focus in the background; the foam stays inside the bowl; short dark hair clippings drift down through a diagonal sunbeam and settle on the marble around the gold scissors, which lie still."
echo "== RETRIES DONE $(date +%T)"
