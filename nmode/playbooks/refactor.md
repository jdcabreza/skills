# Refactor

The behavior stays. The structure changes. This includes a change many callers would notice.

## Steps

Read and follow each file. Skip a conditional step only when its predicate is false. Leave that skip with one line why.

1. `../principles/core/intent/SKILL.md`
2. `../principles/core/be-lazy/SKILL.md`
3. `../principles/engineering/descriptive-code/SKILL.md`
4. `../principles/engineering/test-behavior/SKILL.md`
5. `../principles/core/prove-it/SKILL.md`
6. `../principles/core/domain-facts/SKILL.md` when the move places outside work somewhere new.
7. `../principles/core/verifiable-units/SKILL.md` when the structure change is more than one unit.
8. `../principles/core/assumptions/SKILL.md` when a second fix fails the same gate. That body decides whether another edit happens.
9. `../principles/core/build-the-lever/SKILL.md` when the same edit would be made in many places.
10. `../principles/engineering/separate-writes/SKILL.md` when two actors would write independent facts into one shared target.
