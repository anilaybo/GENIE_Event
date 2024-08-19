#!/usr/bin/bash

ClusterId=$1
ProcId=$2
RandNo=$(( 1314159 + RANDOM %9662607 ))

echo "Loading enviromental variables.."
source /afs/cern.ch/user/your user name/.bashrc

echo "Loading enviromental variables from cvmfs.."
source /cvmfs/ship.cern.ch/SHiP-2018/latest/setUp.sh


echo "Loading enviromental variables for the inputs and Genie confs.."
export INPUTPATH=/eos/experiment/ship/user/your user name/XSec directory/
export GXMLPATH=$INPUTPATH

RandIn=$INPUTPATH/nu_eProd/"$( ls /eos/experiment/ship/user/your user name/XSec directory/nu_eProd | shuf -n 1 )"

cd /afs/cern.ch/user/your user name
eval 'alienv load FairShip/latest' &&

echo "Checking for the output data directory for below events.."
if [  ! -d /eos/experiment/ship/user/your user name/directory name/nu_e/CCDIS/below/"$ClusterId"."$ProcId" ]; then
  mkdir -p /eos/experiment/ship/user/your user name/directory name/nu_e/CCDIS/below/"$ClusterId"."$ProcId"
fi

cd /eos/experiment/ship/user/your user name/directory name/nu_e/CCDIS/below/"$ClusterId"."$ProcId"

echo "Processing e-neutrino flavor for below Genie Events for Generator: CCDIS"

gevgen -n 2661 -p 12 -t 1000822040[0.014],1000822060[0.241],1000822070[0.221],1000822080[0.524] -e 0.0,350.0 --run 1012 -f /eos/experiment/ship/data/Mbias/background-prod-2018/pythia8_Geant4_1.0_withCharm_nu.root,1012 --cross-sections $RandIn --event-generator-list CCDIS --message-thresholds $GENIE/config/Messenger_laconic.xml --seed $RandNo &&

echo "Events for below energy range has been produced for Generator: CCDIS!"

echo "Checking for the output data directory for above events.."
if [  ! -d /eos/experiment/ship/user/your user name/directory name/nu_e/CCDIS/above/"$ClusterId"."$ProcId" ]; then
  mkdir -p /eos/experiment/ship/user/your user name/directory name/nu_e/CCDIS/above/"$ClusterId"."$ProcId"
fi

cd /eos/experiment/ship/user/your user name/directory name/nu_e/CCDIS/above/"$ClusterId"."$ProcId"

echo "Processing e-neutrino flavor for above Genie Events for Generator: CCDIS"

gevgen -n 7339 -p 12 -t 1000822040[0.014],1000822060[0.241],1000822070[0.221],1000822080[0.524] -e 0.0,350.0 --run 1012 -f /eos/experiment/ship/data/Mbias/background-prod-2018/pythia8_Geant4_10.0_withCharm_nu.root,1012 --cross-sections $RandIn --event-generator-list CCDIS --message-thresholds $GENIE/config/Messenger_laconic.xml --seed $RandNo &&

echo "Events for above energy range has been produced for Generator: CCDIS!"
