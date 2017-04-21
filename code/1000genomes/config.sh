#!/usr/bin/env bash

#sample_index=data/1000Genomes_samples_20170101.txt
sample_index=data/1000Genomes_samples_20170314.txt
genome=$HOME/genomes/bowtie2.2.5_indicies/hg38/hg38
master_ref=data/hg38_duf_full_domains_v2.3.bed

# any additional parameters to be passed to bowtie should go here
bowtie_params=""

alignment_dir=alignments
bed_dir=results

if [[ ! -d $alignment_dir ]]; then
        mkdir -p $alignment_dir
fi
if [[ ! -d $bed_dir ]]; then
        mkdir -p $bed_dir
fi
if [[ ! -d logs ]]; then
        mkdir logs
fi

SAMPLES=(
NA19914
HG00623
HG01139
HG01133
HG01134
HG01464
HG01465
HG00270
HG00353
HG00250
HG00251
HG00261
HG01756
HG01761
NA19023
NA19025
NA19720
HG00101
HG00102
HG00105
HG00107
HG00110
HG00113
HG00118
HG00132
HG00134
HG00139
HG00140
HG00236
HG00237
HG00238
HG00240
HG00249
HG00252
HG00253
HG00255
HG00256
HG00257
HG00259
HG00260
HG00268
HG00271
HG00273
HG00288
HG00290
HG00309
HG00334
HG00335
HG00337
HG00341
HG00345
HG00346
HG00359
HG00360
HG00362
HG00364
HG00365
HG00371
HG00376
HG00378
HG00379
HG00381
HG00382
HG00384
HG00407
HG00419
HG00421
HG00422
HG00428
HG00437
HG00442
HG00445
HG00446
HG00448
HG00451
HG00452
HG00457
HG00458
HG00472
HG00473
HG00475
HG00476
HG00478
HG00479
HG00525
HG00536
HG00543
HG00556
HG01051
HG01063
HG01077
HG01085
HG01086
HG01092
HG01104
HG01105
HG01107
HG01108
HG01124
HG01125
HG01136
HG01137
HG01140
HG01149
HG01170
HG01171
HG01173
HG01174
HG01176
HG01256
HG01257
HG01259
HG01260
HG01272
HG01275
HG01277
HG01303
HG01341
HG01342
HG01344
HG01345
HG01347
HG01348
HG01350
HG01351
HG01359
HG01365
HG01392
HG01395
HG01396
HG01402
HG01403
HG01405
HG01412
HG01413
HG01414
HG01437
HG01440
HG01441
HG01461
HG01462
HG01488
HG01489
HG01491
HG01492
HG01524
HG01527
HG01530
HG01531
HG01536
HG01631
HG01697
HG01699
HG01702
HG01757
HG01762
HG01765
HG01766
HG01767
HG01768
HG01770
HG01771
HG01777
HG01779
HG01781
HG01783
HG01784
HG02219
NA06986
NA07000
NA07037
NA07347
NA10847
NA11881
NA11918
NA11919
NA11920
NA11930
NA11993
NA12004
NA12006
NA12044
NA12045
NA12155
NA12156
NA12282
NA12414
NA12489
NA12750
NA12751
NA12763
NA12775
NA12843
NA18489
NA18499
NA18501
NA18504
NA18505
NA18510
NA18519
NA18526
NA18545
NA18546
NA18547
NA18550
NA18561
NA18564
NA18566
NA18570
NA18573
NA18576
NA18577
NA18582
NA18592
NA18593
NA18599
NA18603
NA18605
NA18608
NA18622
NA18623
NA18632
NA18633
NA18636
NA18637
NA18864
NA18870
NA18877
NA18878
NA18912
NA18915
NA18916
NA18939
NA18946
NA18952
NA18955
NA18957
NA18959
NA18966
NA18968
NA18971
NA18974
NA18975
NA18976
NA18978
NA18979
NA18980
NA18981
NA18991
NA18998
NA19001
NA19006
NA19011
NA19017
NA19019
NA19020
NA19024
NA19026
NA19027
NA19028
NA19031
NA19035
NA19036
NA19037
NA19038
NA19041
NA19042
NA19086
NA19089
NA19090
NA19091
NA19099
NA19102
NA19119
NA19131
NA19137
NA19152
NA19171
NA19175
NA19204
NA19225
NA19257
NA19307
NA19308
NA19309
NA19310
NA19314
NA19323
NA19378
NA19454
NA19475
NA19625
NA19648
NA19649
NA19657
NA19658
NA19663
NA19664
NA19669
NA19670
NA19734
NA19735
NA19737
NA19740
NA19741
NA19752
NA19764
NA19792
NA19794
NA19795
NA19913
NA19922
NA19923
NA19984
NA20274
NA20298
NA20318
NA20320
NA20321
NA20351
NA20357
NA20412
NA20506
NA20511
NA20514
NA20517
NA20518
NA20522
NA20524
NA20535
NA20542
NA20543
NA20588
NA20754
NA20755
NA20762
NA20763
NA20764
NA20766
NA20767
NA20768
NA20778
NA20786
NA20787
NA20809
NA20821
NA20822
HG00733
HG01122
HG01205
HG01362
HG01369
HG01431
HG01432
HG01486
HG01556
NA12748
NA12827
HG00261
HG00270
HG01095
HG01353
HG01354
HG01366
HG01375
HG01389
HG01390
HG01393
HG01700
NA07357
NA12717
NA18517
NA18552
NA18555
NA18558
NA18571
NA18861
NA18940
NA19093
NA19114
NA19129
NA19138
NA19320
NA19351
NA19720
NA20355
NA20359
NA20362
"HG00268-2"
"HG00419-2"
"HG00759-1"
"HG00759-2"
"HG01500-1"
"HG01500-2"
"HG01565-1"
"HG01565-2"
"HG01583-1"
"HG01583-2"
"HG01595-1"
"HG01595-2"
"HG02537-1"
"HG02537-2"
"HG02568-1"
"HG02568-2"
"HG03742-1"
"HG03742-2"
"NA06985-1"
"NA06985-2"
"NA12005-1"
"NA12005-2"
"NA18525-1"
"NA18525-2"
"NA18939-1"
"NA20845-1"
"NA20845-2"
)

