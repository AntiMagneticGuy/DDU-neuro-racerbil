# DDU-neuro-racerbil

af Filip Lykke Poulsen

## Der er tilføjet følgende ting til programmet for at gøre evolutionen og brugeroplevelsen bedre.
- Evolution sker ved at klikke på musen (når mindst én bil er kørt over mål-stregen)
- Der er tilføjet 2 yderligere målstrege for at sørge for, at bilerne laver en hel rundte.
- Mutationen bliver mindre og mindre, i takt med at bilerne bliver bedre og bedre
- Den førende bil er lyseblå
- Den tidligere bedste bil (fra sidste rundte) er farvet mørkeblå
- Alle biler er farvet i et spektrum af rød (værst) og grøn (bedst) afhængig af fitness point.
- holder styr på, hvorvidt den sidste vinder har vundet flere runder i træk

## Fitness-points:
- Blå -> lyserød -> grøn (giver et stort antal point) -> blå...
- hvid: fjerner 0.5 point per frame (med en grænse for, hvor lavt det kan blive)
- points for hastighed fra blå til grøn.

