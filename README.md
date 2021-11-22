## Installing

```
cd tarantool/build
git clone https://github.com/AnastasMIPT/ModuleNameExperiments
cd ./ModuleNameExperiments
chmod +x ./experiment.lua
```

## Running

```
./experiment.lua
```

## Results
I. Default log time

mean =  1.22123270655556 max =  2.223104463 min =  3.218848195

II. Time without changing code with simple approach module name

mean =  4.3435144995 max =  5.346481201 min =  6.34124783

II. Time without changing code with simple approach just file

mean =  7.30735176925 max =  8.308728556 min =  9.306057135

III. Time with Alexandr Turenko's approach with module code changes

mean =  10.22134047622222 max =  11.22267143000001 min =  12.219768248

IV. Time with Igor Munkin's modification of Alexander Turenko's approach, without module code changes

mean =  13.22147409583333 max =  14.22285399999999 min =  15.218935484

without changing code     1.655197325569644  times slower than Alexandr Turenko's approach
without changing code       1.755272927248547  times slower than default approach

RPS

Default approach                                        452012.73155734

Simple approach without changing code with module name  291108.52713802

without changing code with just file                    325360.09226178

Alexandr Turenko's approach                             451792.64862339

Igor Munkin's modification                              451520.073369

