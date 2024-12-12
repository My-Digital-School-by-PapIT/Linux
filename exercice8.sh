#!/usr/bin/bash
# Pour les fichiers porteur.csv et receveur.csv vérifier que les transactions sont uniques
# utilisant cut, la transaction en colonne 1

for file in receveur.csv porteur.csv;
do
uniq_lines="$(cut -f 1  -d , $file | uniq | wc -l)"
lines="$(cut -f 1  -d , $file | wc -l)"
if [ $uniq_lines != $lines ]; then
  exit 2
else
  echo "Même nombre de lignes"
fi
done

cut -f 2,4  -d , receveur.csv > receveur_light.csv
cut -f 2,4  -d , porteur.csv > porteur_light.csv
