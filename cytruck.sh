#!/bin/bash
fichier=`cat data.csv | head -10 | tail -9 | cut -d';' -f6| sort -r -d`
echo $fichier
