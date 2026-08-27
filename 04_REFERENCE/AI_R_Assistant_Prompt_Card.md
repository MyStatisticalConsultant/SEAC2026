# AI as an R Assistant - Prompt Card

**Optional SEAC 2026 workshop extension**

Use AI to adapt and troubleshoot **validated workshop code**, not to silently replace the statistical method.

## 1. Good uses

- change graph titles, labels and text size;
- change PNG dimensions/resolution;
- adapt the script to different column names;
- explain an R error in plain language;
- identify a missing package/object;
- explain what a line of R code does.

## 2. Safe prompt structure

Give:

1. **Context** - which workshop script/method you are using.
2. **Goal** - the exact change you want.
3. **Evidence** - relevant code and complete error/output.
4. **Constraint** - what must not change.

## 3. Customise a graph

```text
I am using validated R code from a circular-statistics workshop.
The statistical calculation is correct.

Please change only:
- title to: [TITLE]
- x-axis label to: [LABEL]
- base text size to 14 pt
- output to a 300 dpi PNG, 180 mm wide

Do NOT change:
- the analysed variable;
- circular versus linear treatment;
- kernel;
- bandwidth;
- uncertainty treatment;
- normalisation;
- statistical test.

Return the complete corrected R code and mark the lines changed.

[PASTE CODE]
```

## 4. Fix an error

```text
I am running this validated R workshop code in RStudio on Windows.

Code:
[PASTE RELEVANT CODE]

Complete error message:
[PASTE ERROR]

Please:
1. explain the error in non-technical language;
2. identify the most likely cause;
3. give the smallest correction;
4. return the corrected code block;
5. do not replace the statistical method.
```

## 5. Adapt column names

```text
The workshop script expects:
[LIST EXPECTED COLUMNS]

My data contain:
[PASTE colnames(mydata)]

Tell me exactly which lines to change so the same analysis works.
Preserve all statistical calculations and parameter values.
```

## 6. Evidence to provide when debugging

Useful commands:

```r
sessionInfo()
getwd()
colnames(dat)
head(dat)
```

plus the exact error and the smallest relevant code block.

## 7. Never let AI silently change

- analysed variable;
- degrees versus radians;
- circular versus linear;
- directional versus axial;
- kernel;
- bandwidth/multiplier;
- uncertainty meaning;
- normalisation;
- significance level;
- sample filtering;
- missing-data handling.

## 8. Useful final sentence

```text
If the requested change requires altering the statistical method, do not
alter it silently. Explain why first and keep the original method unless I
explicitly approve the methodological change.
```

## 9. Privacy

Use the workshop's synthetic datasets for practice. Before sending unpublished or restricted research data to an online AI service, follow your institution's rules and the applicable service/account settings.

## 10. Human verification

After accepting AI-generated R code:

1. run it;
2. check warnings/errors;
3. compare with the known-working version;
4. confirm that the method and parameters are unchanged;
5. save the final code with the research files.

**Use AI to reduce coding friction, not to outsource methodological judgement.**
