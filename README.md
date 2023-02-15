# DDU-neuro-racerbil

af Filip Lykke Poulsen

## Der er tilføjet følgende ting til programmet for at gøre evolutionen og brugeroplevelsen bedre.
- Evolution sker ved at klikke på musen (når mindst én bil er kørt over mål-stregen)
- Der er tilføjet 2 yderligere målstrege for at sørge for, at bilerne kører en hel rundte
- Mutations variationen bliver mindre og mindre, i takt med at bilerne bliver bedre og bedre
- Den førende bil er lyseblå
- Den tidligere bedste bil (fra sidste rundte) er farvet mørkeblå
- Alle biler er farvet i et spektrum af rød (værst) og grøn (bedst) afhængig af fitness point
- Der holdes styr på, hvorvidt den sidste vinder har vundet flere runder i træk

## Fitness-points:
- Blå -> rød -> grøn (giver 300 point) -> blå...
- fra de overstående point bliver der trukket point fra, afhængig af hvor lang tid runden tager at gennemføre (maks 200)
- hvid: fjerner 0.5 point per frame (med en grænse for, hvor lavt det kan blive)

## Evolutionen

Når bilerne laver evolution, sker følgende:
 - bilerne bliver sorteret efter fitness
 - Der sker ikke noget med de 10 bedste (de går videre til næste rundte)
 - resten bliver klonet til at ligne top 10, og dernæst tilfældigt mutere med mutations variationen.
