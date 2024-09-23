

#!/bin/bash

# Liste des IDs des volumes EBS associés à chaque instance
VOLUMES=(
  "vol-08db0d84a29719f24"  # Volume 1 (pour instance back 1)
  "vol-0e8d18eb261c4de2d"  # Volume 2 (ex: pour instance back 2)
  "vol-03c61679933e2943c"  # Volume 3 (ex: pour instance front 1)
  "vol-07cbb4b36b26ed2d8"  # Volume 4 (ex: pour instance front 2)
)

# Création d'un snapshot pour chaque volume
for VOLUME_ID in "${VOLUMES[@]}"; do
  DESCRIPTION="Snapshot automatique de la base de données pour le volume $VOLUME_ID à $(date +"%Y-%m-%d %H:%M:%S")"
  
# Création d'un snapshot
  aws ec2 create-snapshot \
      --volume-id $VOLUME_ID \
      --description "$DESCRIPTION"

  # Vérifier si la commande a réussi
  if [ $? -eq 0 ]; then
      echo "Snapshot pour le volume $VOLUME_ID créé avec succès à $(date)"
  else
      echo "Erreur lors de la création du snapshot pour le volume $VOLUME_ID à $(date)"
  fi
done

# Supprimer les snapshots plus vieux que 30 jours pour chaque volume pour gain de place
for VOLUME_ID in "${VOLUMES[@]}"; do
  OLD_SNAPSHOTS=$(aws ec2 describe-snapshots --filters "Name=volume-id,Values=$VOLUME_ID" --query "Snapshots[?StartTime<'$(date -d '-30 days' --utc +'%Y-%m-%dT%H:%M:%S.000Z')'].SnapshotId" --output text)
  
  for SNAPSHOT in $OLD_SNAPSHOTS; do
      aws ec2 delete-snapshot --snapshot-id $SNAPSHOT
      echo "Snapshot $SNAPSHOT supprimé pour le volume $VOLUME_ID"
  done
done


