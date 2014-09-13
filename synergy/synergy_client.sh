#!/bin/bash
ssh -f -N -L localhost:24800:10.0.0.9:24800 max@10.0.0.9 -i /home/max/.ssh/synergy && /usr/bin/synergyc -f localhost
