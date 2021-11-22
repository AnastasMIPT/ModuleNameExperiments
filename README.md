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
## Related issues
[Per-module logging](https://github.com/tarantool/tarantool/issues/3211)

## Results
The experiment was conducted on a dev4 machine.
Here are five ways I've compared them to each other:

I. Default log time

II. Time without changing code with simple approach module name

III. Time without changing code with simple approach just file

IV. Time with Alexandr Turenko's approach with module code changes

V. Time with Igor Munkin's modification of Alexander Turenko's approach, without module code changes


|                                  | mean    | max      | min    |
| :---                             | :-----: |  :----:  | ---:   |
| I.   Default approach            | 0.2119  | 0.2308   | 0.2020 |
| II.  Simple approach module name | 0.3501  | 0.3536   | 0.3467 |
| III. Simple approach just file   | 0.3109  | 0.3119   | 0.3094 |
| IV.  Alexandr Turenko's approach | 0.2037  | 0.2056   | 0.2023 |
| V.   Igor Munkin's modification  | 0.2105  | 0.2261   | 0.2031 |

|                                  | Need to modify module's code | RPS        |
| :---                             | :---                         |    :----:   |
| I.   Default approach            |  No                          | 471916.46   | 
| II.  Simple approach module name |  No                          | 285553.80   |
| III. Simple approach just file   |  No                          | 321612.82   |
| IV.  Alexandr Turenko's approach |  Yes                         | 490686.84   |
| V.   Igor Munkin's modification  |  No                          | 475016.25   |
