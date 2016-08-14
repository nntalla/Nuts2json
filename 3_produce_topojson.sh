#!/usr/bin/env bash

margin=5
for proj in "laea" "wm" #"etrs89"
do
    for size in 1200 1000 800 600 400
    do
        for level in 0 1 2 3
        do
            #make directory
            dir="json/topojson/"$proj"/"$size"px"
            mkdir -p $dir

            if [ $proj = "etrs89" ]
            then

            echo "Not supported yet"
            #-s 1e-7

            #compute resolution
            #res=0
            #if [ $proj = "etrs89" ]
            #    #then res=$((200*$scaleM))
            #    then res=$(echo "$scaleM / 60" | bc -l)
            #    else res=$((200*$scaleM))
            #fi

            else

            echo "   Produce topojson - lvl"$level" - "$proj" - "$size"px"
            topojson -o \
                $dir"/NUTS_lvl"$level".json" \
                "nutsrg=tmp/"$proj"/RGbylevel/RG_lvl"$level".shp" \
                "nutsbn=tmp/"$proj"/BNbylevel/BN_lvl"$level".shp" \
                "cntrg=tmp/"$proj"/CNTR_RG.shp" \
                "cntbn=tmp/"$proj"/CNTR_BN.shp" \
                -p id=NUTS_ID,id=CNTR_ID,na=name,eu=EU_FLAG,efta=EFTA_FLAG,cc=CC_FLAG,lvl=STAT_LEVL_,oth=OTHR_CNTR_ \
                --id-property NUTS_ID \
                -e "shp/NUTS_AT_2013_prep.csv" \
                --width $size --height $size --margin $margin \
                -s 7
            fi
        done
    done
done
