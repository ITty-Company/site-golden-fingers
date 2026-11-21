#!/bin/zsh
# second sequential retry chain; starts only after retries.sh has finished
cd /Users/anastasiia.krasnova/Projects/site-factory
while pgrep -f "clips/retries.sh" >/dev/null; do sleep 20; done
R=sites/golden-fingers/clips/retry.sh
PRE="One continuous shot, no cuts, photoreal, cinematic, silent, constant smooth speed, gentle parallax, no people, no hands."
zsh $R f6b k6 k7 86 "$PRE The camera slowly tilts and lowers from a high angle down to counter height while pushing in toward the small round open brass tin of pomade on the white marble; the single leather strop with the single razor stays in place behind it; warm golden-hour light floods in and amber caustic light ripples across the marble. Nothing is duplicated, all objects keep their shape."
echo "== RETRIES2 DONE $(date +%T)"
